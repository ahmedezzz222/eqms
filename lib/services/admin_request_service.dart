import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'firebase_service.dart';
import 'admin_service.dart';
import 'distribution_area_service.dart';

/// Service for managing Admin Requests
class AdminRequestService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('adminRequests');

  /// Create a new admin request
  static Future<String> createRequest(Admin admin, {bool isNewDistributionArea = false}) async {
    final docRef = await _collection.add({
      'country': admin.country,
      'governorate': admin.governorate,
      'city': admin.city,
      'distributionPoint': admin.distributionPoint,
      'distributionPointDescription': admin.distributionPointDescription,
      'fullName': admin.fullName,
      'mobile': admin.mobile,
      'password': admin.password ?? admin.mobile, // Store password
      'role': admin.role, // Store requested role
      'notes': admin.notes,
      'reference': admin.reference,
      'status': 'pending', // All requests start as pending
      'isRequestedByGuest': true,
      'isNewDistributionArea': isNewDistributionArea, // Flag to indicate if new area needs to be created
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Get all pending admin requests
  static Stream<List<Admin>> getAllRequests() {
    try {
      return _collection
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .map((snapshot) {
            final requests = snapshot.docs
                .map((doc) => _documentToAdmin(doc))
                .toList();
            // Sort by createdAt descending (client-side to avoid composite index)
            requests.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return requests;
          })
          .handleError((error) {
            print('Error fetching admin requests: $error');
            return <Admin>[];
          });
    } catch (e) {
      print('Error creating stream for admin requests: $e');
      return Stream.value(<Admin>[]);
    }
  }

  /// Get all admin requests (pending, approved, rejected) for history
  static Stream<List<Admin>> getAllRequestsHistory() {
    try {
      return _collection
          .snapshots()
          .map((snapshot) {
            final requests = snapshot.docs
                .map((doc) => _documentToAdmin(doc))
                .toList();
            // Sort by createdAt descending
            requests.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return requests;
          })
          .handleError((error) {
            print('Error fetching admin requests history: $error');
            return <Admin>[];
          });
    } catch (e) {
      print('Error creating stream for admin requests history: $e');
      return Stream.value(<Admin>[]);
    }
  }

  /// Get count of pending admin requests
  static Stream<int> getPendingRequestsCount() {
    try {
      return _collection
          .where('status', isEqualTo: 'pending')
          .snapshots()
          .map((snapshot) => snapshot.docs.length)
          .handleError((error) {
            print('Error fetching pending requests count: $error');
            return 0;
          });
    } catch (e) {
      print('Error creating stream for pending requests count: $e');
      return Stream.value(0);
    }
  }

  /// Get admin request by ID
  static Future<Admin?> getRequestById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToAdmin(doc);
    }
    return null;
  }

  /// Approve an admin request (creates admin and updates request status)
  static Future<void> approveRequest(String requestId, String? role) async {
    try {
      // Get the request document to check for isNewDistributionArea flag
      final requestDoc = await _collection.doc(requestId).get();
      if (!requestDoc.exists) {
        throw Exception('Admin request not found');
      }
      
      final requestData = requestDoc.data() as Map<String, dynamic>;
      final request = await getRequestById(requestId);
      if (request == null) {
        throw Exception('Admin request not found');
      }

      // Check if this is a new distribution area that needs to be created
      final isNewDistributionArea = requestData['isNewDistributionArea'] ?? false;
      
      // If it's a new distribution area, create it first
      if (isNewDistributionArea) {
        try {
          final newArea = DistributionArea(
            id: '', // Will be set by Firestore
            country: request.country,
            governorate: request.governorate,
            city: request.city,
            areaName: request.distributionPoint,
          );
          final areaId = await DistributionAreaService.createArea(newArea);
          print('✅ Created new distribution area with ID: $areaId');
        } catch (e) {
          print('⚠️ Could not create distribution area: $e');
          // Continue anyway - admin will still be created
        }
      }

      // Create admin from request
      final admin = Admin(
        id: '', // Will be set by Firestore
        country: request.country,
        governorate: request.governorate,
        city: request.city,
        distributionPoint: request.distributionPoint,
        distributionPointDescription: request.distributionPointDescription,
        fullName: request.fullName,
        mobile: request.mobile,
        password: request.password,
        role: role ?? request.role ?? 'Q_Admin', // Use provided role, or request role, or default to Q_Admin
        notes: request.notes,
        reference: request.reference,
        status: 'active',
        isRequestedByGuest: true,
        createdAt: DateTime.now(),
      );

      // Create admin in admins collection
      final adminId = await AdminService.createAdmin(admin);

      // Update request status to approved
      await _collection.doc(requestId).update({
        'status': 'approved',
        'adminId': adminId, // Link to created admin
        'updatedAt': FieldValue.serverTimestamp(),
      });

      print('✅ Admin request approved and admin created with ID: $adminId');
    } catch (e) {
      print('❌ Error approving admin request: $e');
      rethrow;
    }
  }

  /// Reject an admin request
  static Future<void> rejectRequest(String requestId) async {
    try {
      await _collection.doc(requestId).update({
        'status': 'rejected',
        'updatedAt': FieldValue.serverTimestamp(),
      });
      print('✅ Admin request rejected');
    } catch (e) {
      print('❌ Error rejecting admin request: $e');
      rethrow;
    }
  }

  /// Delete an admin request
  static Future<void> deleteRequest(String id) async {
    await _collection.doc(id).delete();
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
      password: data['password'],
      notes: data['notes'] ?? '',
      reference: data['reference'],
      status: data['status'] ?? 'pending',
      isRequestedByGuest: data['isRequestedByGuest'] ?? true,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

