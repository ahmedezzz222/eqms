import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';
import 'firebase_service.dart';
import 'role_service.dart';

/// Service for managing Admins
class AdminService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('admins');
  
  // Store current logged-in admin
  static String? _currentAdminId;
  static Admin? _currentAdmin;
  
  static String? get currentAdminId => _currentAdminId;
  static Admin? get currentAdmin => _currentAdmin;
  
  /// Set current admin (called after successful login)
  static void setCurrentAdmin(String adminId, Admin? admin) {
    _currentAdminId = adminId;
    _currentAdmin = admin;
  }
  
  /// Set current admin by ID (fetches from Firestore)
  static Future<void> setCurrentAdminById(String adminId) async {
    _currentAdminId = adminId;
    _currentAdmin = await getAdminById(adminId);
  }
  
  /// Clear current admin (called on logout)
  static void clearCurrentAdmin() {
    _currentAdminId = null;
    _currentAdmin = null;
  }

  /// Get all admins
  static Stream<List<Admin>> getAllAdmins() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => _documentToAdmin(doc))
            .toList());
  }

  /// Get admin by ID
  static Future<Admin?> getAdminById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToAdmin(doc);
    }
    return null;
  }

  /// Get admin by mobile number
  static Future<Admin?> getAdminByMobile(String mobile) async {
    final query = await _collection
        .where('mobile', isEqualTo: mobile)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return _documentToAdmin(query.docs.first);
    }
    return null;
  }

  /// Authenticate admin by mobile and password
  /// Returns Admin if credentials are valid, null otherwise
  /// Includes retry logic and Safari-specific fallback strategies
  static Future<Admin?> authenticateAdmin(String mobile, String password) async {
    print('🔐 Starting authentication for mobile: $mobile');
    
    // Strategy 1: Try using getAdminByMobile (simpler query, better for Safari)
    try {
      print('📱 Strategy 1: Using getAdminByMobile...');
      final admin = await getAdminByMobile(mobile)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              print('⚠️ getAdminByMobile timed out');
              throw TimeoutException('getAdminByMobile timed out', const Duration(seconds: 10));
            },
          );
      
      if (admin != null) {
        print('✅ Admin found via getAdminByMobile');
        // Check password
        if (admin.password == password && admin.status == 'active') {
          print('✅ Authentication successful via Strategy 1');
          return admin;
        } else {
          print('⚠️ Password mismatch or inactive status');
          return null;
        }
      }
    } catch (e) {
      print('⚠️ Strategy 1 failed: $e');
      // Continue to Strategy 2
    }
    
    // Strategy 2: Try direct where query with different source strategies
    const maxRetries = 3;
    const retryDelay = Duration(milliseconds: 800);
    
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        print('🔐 Strategy 2, attempt $attempt/$maxRetries: Using where query...');
        
        // For Safari, try different source strategies
        Source source;
        if (attempt == 1) {
          source = Source.serverAndCache; // First: try both
        } else if (attempt == 2) {
          source = Source.cache; // Second: try cache only
        } else {
          source = Source.server; // Final: try server only
        }
        
        final query = await _collection
            .where('mobile', isEqualTo: mobile)
            .limit(1)
            .get(GetOptions(source: source))
            .timeout(
              const Duration(seconds: 12),
              onTimeout: () {
                print('⚠️ Where query timed out on attempt $attempt');
                throw TimeoutException(
                  'Where query timed out', 
                  const Duration(seconds: 12)
                );
              },
            );
        
        if (query.docs.isEmpty) {
          print('⚠️ Admin not found in where query (attempt $attempt)');
          // Don't retry if not found - admin doesn't exist
          return null;
        }
        
        final doc = query.docs.first;
        final data = doc.data() as Map<String, dynamic>;
        
        // Check password
        final storedPassword = data['password'] as String?;
        if (storedPassword == null || storedPassword != password) {
          print('⚠️ Password mismatch (attempt $attempt)');
          return null;
        }
        
        // Check status
        final status = data['status'] as String? ?? 'pending';
        if (status != 'active') {
          print('⚠️ Admin status is not active: $status (attempt $attempt)');
          return null;
        }
        
        print('✅ Authentication successful via Strategy 2, attempt $attempt');
        return _documentToAdmin(doc);
      } on TimeoutException catch (e) {
        print('❌ Strategy 2 timeout on attempt $attempt: $e');
        if (attempt < maxRetries) {
          print('⏳ Retrying after ${retryDelay.inMilliseconds}ms...');
          await Future.delayed(retryDelay);
          continue;
        }
      } catch (e) {
        print('❌ Strategy 2 error on attempt $attempt: $e');
        final errorString = e.toString().toLowerCase();
        final isRetryableError = errorString.contains('network') ||
            errorString.contains('connection') ||
            errorString.contains('timeout') ||
            errorString.contains('failed host lookup') ||
            errorString.contains('socket') ||
            errorString.contains('permission-denied') ||
            errorString.contains('unavailable');
        
        if (isRetryableError && attempt < maxRetries) {
          print('⏳ Retryable error, retrying after ${retryDelay.inMilliseconds}ms...');
          await Future.delayed(retryDelay);
          continue;
        } else {
          print('❌ Non-retryable error or max retries reached');
          break;
        }
      }
    }
    
    // Strategy 3: Fallback - fetch limited admins and filter client-side (Safari fallback)
    try {
      print('🔐 Strategy 3: Fallback - fetching admins and filtering client-side...');
      final query = await _collection
          .limit(100) // Reasonable limit
          .get(GetOptions(source: Source.serverAndCache))
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              print('⚠️ Fallback query timed out');
              throw TimeoutException('Fallback query timed out', const Duration(seconds: 15));
            },
          );
      
      for (var doc in query.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final docMobile = data['mobile'] as String?;
        
        if (docMobile == mobile) {
          final storedPassword = data['password'] as String?;
          final status = data['status'] as String? ?? 'pending';
          
          if (storedPassword == password && status == 'active') {
            print('✅ Authentication successful via Strategy 3 (fallback)');
            return _documentToAdmin(doc);
          } else {
            print('⚠️ Password mismatch or inactive status in fallback');
            return null;
          }
        }
      }
      
      print('⚠️ Admin not found in fallback strategy');
      return null;
    } catch (e) {
      print('❌ Strategy 3 (fallback) failed: $e');
      return null;
    }
  }

  /// Get pending admin requests
  static Stream<List<Admin>> getPendingRequests() {
    return _collection
        .where('status', isEqualTo: 'pending')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => _documentToAdmin(doc))
            .toList());
  }

  /// Create admin request (for guest users)
  static Future<String> createAdminRequest(Admin admin) async {
    final docRef = await _collection.add({
      'country': admin.country,
      'governorate': admin.governorate,
      'city': admin.city,
      'distributionPoint': admin.distributionPoint,
      'distributionPointDescription': admin.distributionPointDescription,
      'fullName': admin.fullName,
      'mobile': admin.mobile,
      'password': admin.mobile, // In real app, hash the password
      'notes': admin.notes,
      'reference': admin.reference,
      'status': 'pending',
      'isRequestedByGuest': admin.isRequestedByGuest,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Approve admin request
  static Future<void> approveAdminRequest(
      String id, String approvedBy) async {
    await _collection.doc(id).update({
      'status': 'active',
      'approvedBy': approvedBy,
      'approvedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Reject admin request
  static Future<void> rejectAdminRequest(String id) async {
    await _collection.doc(id).update({
      'status': 'banned',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update admin
  static Future<void> updateAdmin(String id, Admin admin) async {
    await _collection.doc(id).update({
      'country': admin.country,
      'governorate': admin.governorate,
      'city': admin.city,
      'distributionPoint': admin.distributionPoint,
      'distributionPointDescription': admin.distributionPointDescription,
      'fullName': admin.fullName,
      'mobile': admin.mobile,
      'notes': admin.notes,
      'reference': admin.reference,
      'status': admin.status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update admin password
  static Future<void> updateAdminPassword(String id, String newPassword) async {
    await _collection.doc(id).update({
      'password': newPassword, // In production, hash the password
      'updatedAt': FieldValue.serverTimestamp(),
    });
    
    // Update current admin if it's the same admin
    if (_currentAdminId == id && _currentAdmin != null) {
      _currentAdmin = _currentAdmin!.copyWith(password: newPassword);
    }
  }

  /// Delete admin
  static Future<void> deleteAdmin(String id) async {
    await _collection.doc(id).delete();
  }

  /// Login admin (authenticate with Firebase Auth)
  static Future<UserCredential?> loginAdmin(String mobile, String password) async {
    try {
      // In real app, you would verify password from Firestore
      // For now, we'll use Firebase Auth with email/password
      // You may need to use phone authentication instead
      final credential = await FirebaseService.auth.signInWithEmailAndPassword(
        email: '$mobile@eqms.app', // Use mobile as email
        password: password,
      );
      return credential;
    } catch (e) {
      return null;
    }
  }

  /// Create admin (for super admin)
  static Future<String> createAdmin(Admin admin) async {
    // Get role ID from roles collection if role name is provided
    String? roleId;
    if (admin.role != null && admin.role!.isNotEmpty) {
      roleId = await _getRoleIdByName(admin.role!);
      if (roleId == null) {
        // Role doesn't exist, create it
        print('⚠️ Role ${admin.role} not found in roles collection, creating it...');
        // This should not happen if roles are initialized, but handle it gracefully
        throw Exception('Role ${admin.role} not found. Please ensure roles are initialized.');
      }
    }

    final docRef = await _collection.add({
      'country': admin.country,
      'governorate': admin.governorate,
      'city': admin.city,
      'distributionPoint': admin.distributionPoint,
      'distributionPointDescription': admin.distributionPointDescription,
      'fullName': admin.fullName,
      'mobile': admin.mobile,
      'password': admin.password ?? admin.mobile, // Store password (in production, hash it)
      'role': admin.role, // Store role name for quick access
      'roleId': roleId, // Store role ID reference to roles collection
      'notes': admin.notes,
      'reference': admin.reference,
      'status': admin.status,
      'isRequestedByGuest': false,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Helper method to get role ID by name
  static Future<String?> _getRoleIdByName(String roleName) async {
    try {
      // Use RoleService to get role ID
      return await RoleService.getRoleIdByName(roleName);
    } catch (e) {
      print('Error getting role ID: $e');
      return null;
    }
  }

  /// Convert Firestore document to Admin model
  static Admin _documentToAdmin(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Admin(
      id: doc.id,
      country: data['country'] ?? '',
      governorate: data['governorate'] ?? '',
      city: data['city'] ?? '',
      distributionPoint: data['distributionPoint'] ?? '',
      distributionPointDescription: data['distributionPointDescription'],
      fullName: data['fullName'] ?? '',
      mobile: data['mobile'] ?? '',
      password: data['password'], // Don't expose password in model
      role: data['role'],
      notes: data['notes'] ?? '',
      reference: data['reference'],
      status: data['status'] ?? 'pending',
      isRequestedByGuest: data['isRequestedByGuest'] ?? false,
      createdAt: data['createdAt'] != null
          ? FirebaseService.timestampToDateTime(data['createdAt'] as Timestamp)
          : DateTime.now(),
    );
  }
}

