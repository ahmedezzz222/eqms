import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'firebase_service.dart';

/// Service for managing Beneficiaries
class BeneficiaryService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('beneficiaries');

  /// Get all beneficiaries with pagination support
  static Stream<List<Beneficiary>> getAllBeneficiaries({int? limit, bool activeOnly = false}) {
    Query query;
    
    // If activeOnly is true, we can't use orderBy with where (requires composite index)
    // So we'll filter and sort client-side for better compatibility
    if (activeOnly) {
      query = _collection.where('status', isEqualTo: 'Active');
    } else {
      query = _collection.orderBy('createdAt', descending: true);
    }
    
    if (limit != null && limit > 0) {
      query = query.limit(limit);
    }
    
    return FirebaseService.withRetry<QuerySnapshot>(
      () => query.snapshots(),
      maxRetries: 5,
      initialDelay: const Duration(seconds: 1),
    ).map((snapshot) {
      final beneficiaries = snapshot.docs
          .map((doc) => _documentToBeneficiary(doc))
          .toList();
      
      // Sort by createdAt descending if activeOnly (client-side sort)
      if (activeOnly) {
        beneficiaries.sort((a, b) {
          // We need to get createdAt from the document
          // For now, sort by ID (newer IDs come later) or use a timestamp if available
          return b.id.compareTo(a.id); // Simple fallback
        });
      }
      
      return beneficiaries;
    });
  }
  
  /// Get paginated beneficiaries (for initial load)
  static Future<List<Beneficiary>> getBeneficiariesPaginated({
    int limit = 100,
    DocumentSnapshot? startAfter,
    bool activeOnly = false,
  }) async {
    Query query;
    
    // If activeOnly is true, we can't use orderBy with where (requires composite index)
    if (activeOnly) {
      query = _collection.where('status', isEqualTo: 'Active');
    } else {
      query = _collection.orderBy('createdAt', descending: true);
    }
    
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    
    query = query.limit(limit);
    
    final snapshot = await query.get();
    final beneficiaries = snapshot.docs.map((doc) => _documentToBeneficiary(doc)).toList();
    
    // Sort by createdAt descending if activeOnly (client-side sort)
    if (activeOnly) {
      beneficiaries.sort((a, b) => b.id.compareTo(a.id)); // Simple fallback
    }
    
    return beneficiaries;
  }

  /// Get beneficiaries by distribution area with pagination support
  static Stream<List<Beneficiary>> getBeneficiariesByArea(String areaId, {int? limit, bool activeOnly = false}) {
    Query query = _collection.where('distributionArea', isEqualTo: areaId);
    
    // If activeOnly is true, we can't use orderBy with multiple where clauses (requires composite index)
    if (activeOnly) {
      query = query.where('status', isEqualTo: 'Active');
    }
    
    // Don't use orderBy with where clause to avoid composite index requirement
    // We'll sort client-side instead
    
    if (limit != null && limit > 0) {
      query = query.limit(limit);
    }
    
    return FirebaseService.withRetry<QuerySnapshot>(
      () => query.snapshots(),
      maxRetries: 5,
      initialDelay: const Duration(seconds: 1),
    ).map((snapshot) {
          // Always sort client-side to avoid composite index requirement
          final docsWithData = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAt = data['createdAt'] as Timestamp?;
            return {
              'doc': doc,
              'createdAt': createdAt,
            };
          }).toList();
          
          // Sort by createdAt descending (newest first)
          docsWithData.sort((a, b) {
            final aTime = a['createdAt'] as Timestamp?;
            final bTime = b['createdAt'] as Timestamp?;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime);
          });
          
          // Convert sorted documents to beneficiaries
          final beneficiaries = docsWithData
              .map((item) => _documentToBeneficiary(item['doc'] as DocumentSnapshot))
              .toList();
          
          return beneficiaries;
        });
  }
  
  /// Get paginated beneficiaries by area
  static Future<List<Beneficiary>> getBeneficiariesByAreaPaginated({
    required String areaId,
    int limit = 100,
    DocumentSnapshot? startAfter,
    bool activeOnly = false,
  }) async {
    Query query = _collection.where('distributionArea', isEqualTo: areaId);
    
    if (activeOnly) {
      query = query.where('status', isEqualTo: 'Active');
    }
    
    try {
      query = query.orderBy('createdAt', descending: true);
    } catch (e) {
      print('Note: Could not use orderBy: $e');
    }
    
    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }
    
    query = query.limit(limit);
    
    final snapshot = await query.get();
    return snapshot.docs.map((doc) => _documentToBeneficiary(doc)).toList();
  }

  /// Get beneficiaries by queue name
  static Stream<List<Beneficiary>> getBeneficiariesByQueueName(String queueName) {
    // Removed verbose logging to prevent excessive log spam during StreamBuilder rebuilds
    return FirebaseService.withRetry<QuerySnapshot>(
      () => _collection.where('initialAssignedQueuePoint', isEqualTo: queueName).snapshots(),
      maxRetries: 5,
      initialDelay: const Duration(seconds: 1),
    ).map((snapshot) {
          // Sort by createdAt descending client-side to avoid composite index requirement
          final docsWithData = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAt = data['createdAt'] as Timestamp?;
            return {
              'doc': doc,
              'createdAt': createdAt,
            };
          }).toList();
          
          // Sort by createdAt descending (newest first)
          docsWithData.sort((a, b) {
            final aTime = a['createdAt'] as Timestamp?;
            final bTime = b['createdAt'] as Timestamp?;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime);
          });
          
          // Convert sorted documents to beneficiaries
          final beneficiaries = docsWithData
              .map((item) => _documentToBeneficiary(item['doc'] as DocumentSnapshot))
              .toList();
          
          return beneficiaries;
        });
  }

  /// Get beneficiary by ID
  static Future<Beneficiary?> getBeneficiaryById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToBeneficiary(doc);
    }
    return null;
  }

  /// Get beneficiary by ID number
  static Future<Beneficiary?> getBeneficiaryByIdNumber(String idNumber) async {
    final query = await _collection
        .where('idNumber', isEqualTo: idNumber)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return _documentToBeneficiary(query.docs.first);
    }
    return null;
  }

  /// Get beneficiary by mobile number
  static Future<Beneficiary?> getBeneficiaryByMobile(String mobile) async {
    final query = await _collection
        .where('mobileNumber', isEqualTo: mobile)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return _documentToBeneficiary(query.docs.first);
    }
    return null;
  }

  /// Get beneficiary by NFC code
  static Future<Beneficiary?> getBeneficiaryByNFC(String nfcCode) async {
    final query = await _collection
        .where('nfcPreprintedCode', isEqualTo: nfcCode)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return _documentToBeneficiary(query.docs.first);
    }
    return null;
  }

  /// Create a new beneficiary
  static Future<String> createBeneficiary(
      Beneficiary beneficiary, String createdBy) async {
    final docRef = await _collection.add({
      'distributionArea': beneficiary.distributionArea,
      'initialAssignedQueuePoint': beneficiary.initialAssignedQueuePoint,
      'type': beneficiary.type,
      'idCopyPath': beneficiary.idCopyPath,
      'gender': beneficiary.gender,
      'name': beneficiary.name,
      'idNumber': beneficiary.idNumber,
      'mobileNumber': beneficiary.mobileNumber,
      'isEntity': beneficiary.isEntity,
      'entityName': beneficiary.entityName,
      'numberOfUnits': beneficiary.numberOfUnits,
      'nfcPreprintedCode': beneficiary.nfcPreprintedCode,
      'photoPath': beneficiary.photoPath,
      'status': beneficiary.status,
      'birthDate': beneficiary.birthDate != null
          ? FirebaseService.dateTimeToTimestamp(beneficiary.birthDate!)
          : null,
      'queueNumber': beneficiary.queueNumber,
      'isServed': beneficiary.isServed,
      'unitsTaken': beneficiary.unitsTaken,
      'servedAt': null,
      'servedBy': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'createdBy': createdBy,
    });
    return docRef.id;
  }

  /// Update a beneficiary
  static Future<void> updateBeneficiary(String id, Beneficiary beneficiary) async {
    await _collection.doc(id).update({
      'distributionArea': beneficiary.distributionArea,
      'initialAssignedQueuePoint': beneficiary.initialAssignedQueuePoint,
      'type': beneficiary.type,
      'idCopyPath': beneficiary.idCopyPath,
      'gender': beneficiary.gender,
      'name': beneficiary.name,
      'idNumber': beneficiary.idNumber,
      'mobileNumber': beneficiary.mobileNumber,
      'isEntity': beneficiary.isEntity,
      'entityName': beneficiary.entityName,
      'numberOfUnits': beneficiary.numberOfUnits,
      'nfcPreprintedCode': beneficiary.nfcPreprintedCode,
      'photoPath': beneficiary.photoPath,
      'status': beneficiary.status,
      'birthDate': beneficiary.birthDate != null
          ? FirebaseService.dateTimeToTimestamp(beneficiary.birthDate!)
          : null,
      'queueNumber': beneficiary.queueNumber,
      'isServed': beneficiary.isServed,
      'unitsTaken': beneficiary.unitsTaken,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Mark beneficiary as served
  static Future<void> markAsServed(
      String id, int unitsServed, String servedBy) async {
    final beneficiary = await getBeneficiaryById(id);
    if (beneficiary != null) {
      await _collection.doc(id).update({
        'isServed': true,
        'unitsTaken': FieldValue.increment(unitsServed),
        'servedAt': FieldValue.serverTimestamp(),
        'servedBy': servedBy,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Assign queue number to beneficiary
  static Future<void> assignQueueNumber(String id, int queueNumber) async {
    await _collection.doc(id).update({
      'queueNumber': queueNumber,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete a beneficiary
  static Future<void> deleteBeneficiary(String id) async {
    await _collection.doc(id).delete();
  }

  /// Get served beneficiaries with serving information
  static Future<List<Map<String, dynamic>>> getServedBeneficiariesReport(String? distributionAreaId) async {
    Query query = _collection.where('isServed', isEqualTo: true);
    
    if (distributionAreaId != null && distributionAreaId.isNotEmpty) {
      query = query.where('distributionArea', isEqualTo: distributionAreaId);
    }
    
    final snapshot = await query.get();
    final reports = <Map<String, dynamic>>[];
    
    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final beneficiary = _documentToBeneficiary(doc);
      final servedAt = data['servedAt'] as Timestamp?;
      
      reports.add({
        'beneficiary': beneficiary,
        'servedAt': servedAt != null ? FirebaseService.timestampToDateTime(servedAt) : null,
        'servedBy': data['servedBy'],
      });
    }
    
    // Sort by servedAt descending (most recent first)
    reports.sort((a, b) {
      final aTime = a['servedAt'] as DateTime?;
      final bTime = b['servedAt'] as DateTime?;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return bTime.compareTo(aTime);
    });
    
    return reports;
  }

  /// Convert Firestore document to Beneficiary model
  static Beneficiary _documentToBeneficiary(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Beneficiary(
      id: doc.id,
      distributionArea: data['distributionArea'] ?? '',
      initialAssignedQueuePoint: data['initialAssignedQueuePoint'] ?? '',
      type: data['type'] ?? 'Normal',
      idCopyPath: data['idCopyPath'],
      gender: data['gender'] ?? 'Male',
      name: data['name'] ?? '',
      idNumber: data['idNumber'] ?? '',
      mobileNumber: data['mobileNumber'],
      isEntity: data['isEntity'] ?? false,
      entityName: data['entityName'],
      numberOfUnits: data['numberOfUnits'] ?? '1',
      nfcPreprintedCode: data['nfcPreprintedCode'],
      photoPath: data['photoPath'],
      status: data['status'] ?? 'Active',
      birthDate: data['birthDate'] != null
          ? FirebaseService.timestampToDateTime(data['birthDate'] as Timestamp)
          : null,
      queueNumber: data['queueNumber'],
      isServed: data['isServed'] ?? false,
      unitsTaken: data['unitsTaken'] ?? 0,
      createdBy: data['createdBy'],
    );
  }
}

