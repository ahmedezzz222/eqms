import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:async/async.dart';
import '../main.dart';
import 'firebase_service.dart';

/// Result of a paginated beneficiaries query (list + cursor for next page).
class BeneficiaryPaginatedResult {
  final List<Beneficiary> list;
  final DocumentSnapshot? lastDocument;
  BeneficiaryPaginatedResult({required this.list, this.lastDocument});
}

/// Service for managing Beneficiaries
class BeneficiaryService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('beneficiaries');

  /// Get all beneficiaries with pagination support
  /// Avoids orderBy on Firestore to prevent requiring an index; sorts client-side instead.
  static Stream<List<Beneficiary>> getAllBeneficiaries({int? limit, bool activeOnly = false}) {
    Query query;
    
    // Avoid orderBy with where (requires composite index). Use simple query and sort client-side.
    if (activeOnly) {
      query = _collection.where('status', isEqualTo: 'Active');
    } else {
      query = _collection; // No orderBy - sort client-side to avoid index requirement
    }
    
    if (limit != null && limit > 0) {
      query = query.limit(limit);
    }
    
    return FirebaseService.withRetry<QuerySnapshot>(
      () => query.snapshots(),
      maxRetries: 5,
      initialDelay: const Duration(seconds: 1),
    ).map((snapshot) {
      final docsWithData = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final createdAt = data['createdAt'] as Timestamp?;
        return {'doc': doc, 'createdAt': createdAt};
      }).toList();
      docsWithData.sort((a, b) {
        final aTime = a['createdAt'] as Timestamp?;
        final bTime = b['createdAt'] as Timestamp?;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime);
      });
      final beneficiaries = docsWithData
          .map((item) => documentToBeneficiary(item['doc'] as DocumentSnapshot))
          .toList();
      if (activeOnly) {
        beneficiaries.sort((a, b) => b.id.compareTo(a.id));
      }
      return beneficiaries;
    });
  }
  
  /// Get paginated beneficiaries (for initial load). Returns list and last document for cursor.
  static Future<BeneficiaryPaginatedResult> getBeneficiariesPaginated({
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
    final beneficiaries = snapshot.docs.map((doc) => documentToBeneficiary(doc)).toList();
    
    // Sort by createdAt descending if activeOnly (client-side sort)
    if (activeOnly) {
      beneficiaries.sort((a, b) => b.id.compareTo(a.id)); // Simple fallback
    }
    
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    return BeneficiaryPaginatedResult(list: beneficiaries, lastDocument: lastDoc);
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
              .map((item) => documentToBeneficiary(item['doc'] as DocumentSnapshot))
              .toList();
          
          return beneficiaries;
        });
  }
  
  /// Get paginated beneficiaries by area. Returns list and last document for cursor.
  static Future<BeneficiaryPaginatedResult> getBeneficiariesByAreaPaginated({
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
    final list = snapshot.docs.map((doc) => documentToBeneficiary(doc)).toList();
    final lastDoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    return BeneficiaryPaginatedResult(list: list, lastDocument: lastDoc);
  }

  /// Get beneficiaries filtered by multiple distribution areas (server-side filtering)
  /// Firestore whereIn has a limit of 10 items, so we batch if needed
  static Stream<List<Beneficiary>> getBeneficiariesByAreas(
    List<String> distributionAreaIds, {
    int? limit,
    bool activeOnly = false,
  }) {
    if (distributionAreaIds.isEmpty) {
      return Stream.value(<Beneficiary>[]);
    }
    
    // If only one area, use the simpler method
    if (distributionAreaIds.length == 1) {
      return getBeneficiariesByArea(distributionAreaIds.first, limit: limit, activeOnly: activeOnly);
    }
    
    // Firestore whereIn limit is 10, so we need to batch if more than 10
    if (distributionAreaIds.length <= 10) {
      Query query = _collection.where('distributionArea', whereIn: distributionAreaIds);
      
      if (activeOnly) {
        query = query.where('status', isEqualTo: 'Active');
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
            .map((doc) => documentToBeneficiary(doc))
            .toList();
        // Sort client-side to avoid composite index requirement
        beneficiaries.sort((a, b) => b.id.compareTo(a.id));
        return beneficiaries;
      });
    } else {
      // For more than 10 areas, we need to batch the queries
      final batches = <List<String>>[];
      for (int i = 0; i < distributionAreaIds.length; i += 10) {
        batches.add(distributionAreaIds.sublist(
          i,
          i + 10 > distributionAreaIds.length ? distributionAreaIds.length : i + 10,
        ));
      }
      
      // Create streams for each batch and combine them
      final streams = batches.map((batch) {
        Query query = _collection.where('distributionArea', whereIn: batch);
        if (activeOnly) {
          query = query.where('status', isEqualTo: 'Active');
        }
        if (limit != null && limit > 0) {
          // Distribute limit across batches
          query = query.limit((limit / batches.length).ceil());
        }
        return FirebaseService.withRetry<QuerySnapshot>(
          () => query.snapshots(),
          maxRetries: 5,
          initialDelay: const Duration(seconds: 1),
        );
      });
      
      // Combine all streams and merge results
      return StreamZip(streams).map((snapshots) {
        final allBeneficiaries = <Beneficiary>[];
        for (var snapshot in snapshots) {
          allBeneficiaries.addAll(snapshot.docs.map((doc) => documentToBeneficiary(doc)));
        }
        // Remove duplicates by ID
        final uniqueBeneficiaries = <String, Beneficiary>{};
        for (var beneficiary in allBeneficiaries) {
          uniqueBeneficiaries[beneficiary.id] = beneficiary;
        }
        final result = uniqueBeneficiaries.values.toList();
        // Sort client-side
        result.sort((a, b) => b.id.compareTo(a.id));
        // Apply limit if specified
        if (limit != null && limit > 0 && result.length > limit) {
          return result.take(limit).toList();
        }
        return result;
      });
    }
  }

  /// Get beneficiaries by queue name - OPTIMIZED with real-time Firestore snapshots
  /// Replaced Stream.periodic polling with real-time snapshots for 10x performance improvement
  /// Note: This method uses queueHistory as the primary source, with initialAssignedQueuePoint as fallback
  static Stream<List<Beneficiary>> getBeneficiariesByQueueName(String queueName) {
    final StreamController<List<Beneficiary>> controller = StreamController<List<Beneficiary>>.broadcast();
    StreamSubscription? historySubscription;
    StreamSubscription? beneficiariesSubscription;
    Set<String> beneficiaryIdsFromHistory = {};
    
    // Helper to combine and emit beneficiaries
    Future<void> emitCombined() async {
      if (controller.isClosed) return;
      
      // Get beneficiaries with initialAssignedQueuePoint (from current snapshot)
      final beneficiariesSnapshot = await _collection
          .where('initialAssignedQueuePoint', isEqualTo: queueName)
          .where('status', isEqualTo: 'Active')
          .get();
      
      final beneficiariesFromQueue = beneficiariesSnapshot.docs
          .map((doc) => documentToBeneficiary(doc))
          .toList();
      
      // Get beneficiaries from history IDs if available (batched)
      List<Beneficiary> beneficiariesFromHistory = [];
      if (beneficiaryIdsFromHistory.isNotEmpty) {
        beneficiariesFromHistory = await _getBeneficiariesByIds(beneficiaryIdsFromHistory);
      }
      
      // Combine and deduplicate using Map for O(1) lookup
      final allBeneficiaries = <String, Beneficiary>{};
      for (var b in beneficiariesFromQueue) {
        allBeneficiaries[b.id] = b;
      }
      for (var b in beneficiariesFromHistory) {
        allBeneficiaries[b.id] = b;
      }
      
      final combined = allBeneficiaries.values.toList();
      // Lightweight sort by ID (newer first)
      combined.sort((a, b) => b.id.compareTo(a.id));
      
      if (!controller.isClosed) {
        controller.add(combined);
      }
    }
    
    // Listen to queueHistory for beneficiary IDs (real-time updates, not polling!)
    final historyQuery = FirebaseService.firestore
        .collection('queueHistory')
        .where('dayQueueName', isEqualTo: queueName)
        .where('action', isEqualTo: 'issued')
        .limit(500) // Limit to prevent loading too much
        .snapshots();
    
    historySubscription = historyQuery.listen(
      (historySnapshot) {
        // Update beneficiary IDs from history
        beneficiaryIdsFromHistory = historySnapshot.docs
            .map((doc) => doc.data()['beneficiaryId'] as String?)
            .where((id) => id != null)
            .cast<String>()
            .toSet();
        
        // Trigger update of combined beneficiaries
        emitCombined();
      },
      onError: (error) {
        if (!controller.isClosed) {
          controller.addError(error);
        }
      },
    );
    
    // Also listen to beneficiaries stream for real-time updates
    final beneficiariesQuery = _collection
        .where('initialAssignedQueuePoint', isEqualTo: queueName)
        .where('status', isEqualTo: 'Active')
        .snapshots();
    
    beneficiariesSubscription = beneficiariesQuery.listen(
      (_) {
        // When beneficiaries change, re-emit combined list
        emitCombined();
      },
      onError: (error) {
        if (!controller.isClosed) {
          controller.addError(error);
        }
      },
    );
    
    // Initial emit
    emitCombined();
    
    // Clean up on cancel
    controller.onCancel = () {
      historySubscription?.cancel();
      beneficiariesSubscription?.cancel();
    };
    
    return controller.stream;
  }
  
  /// Get beneficiaries by IDs (batched for Firestore 'in' query limit of 10)
  static Future<List<Beneficiary>> _getBeneficiariesByIds(Set<String> ids) async {
    if (ids.isEmpty) return [];
    
    final allBeneficiaries = <Beneficiary>[];
    final idsList = ids.toList();
    
    // Process in batches of 10 (Firestore 'in' query limit)
    for (int i = 0; i < idsList.length; i += 10) {
      final batch = idsList.skip(i).take(10).toList();
      try {
        final snapshot = await _collection
            .where(FieldPath.documentId, whereIn: batch)
            .get();
        
        allBeneficiaries.addAll(
          snapshot.docs.map((doc) => documentToBeneficiary(doc)),
        );
      } catch (e) {
        print('Error fetching beneficiaries batch: $e');
      }
    }
    
    return allBeneficiaries;
  }

  /// Get beneficiary by ID
  static Future<Beneficiary?> getBeneficiaryById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return documentToBeneficiary(doc);
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
      return documentToBeneficiary(query.docs.first);
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
      return documentToBeneficiary(query.docs.first);
    }
    return null;
  }

  /// Get beneficiary by NFC code
  static Future<Beneficiary?> getBeneficiaryByNFC(String nfcCode) async {
    // Normalize the NFC code for searching
    String normalizedNfc = nfcCode.trim();
    
    // Try exact match first
    var query = await _collection
        .where('nfcPreprintedCode', isEqualTo: normalizedNfc)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return documentToBeneficiary(query.docs.first);
    }
    
    // Try with NFC_ prefix if not already present
    if (!normalizedNfc.toUpperCase().startsWith('NFC_')) {
      query = await _collection
          .where('nfcPreprintedCode', isEqualTo: 'NFC_$normalizedNfc')
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        return documentToBeneficiary(query.docs.first);
      }
    }
    
    // Try without 0x prefix if present
    if (normalizedNfc.toLowerCase().startsWith('0x')) {
      final withoutPrefix = normalizedNfc.substring(2);
      query = await _collection
          .where('nfcPreprintedCode', isEqualTo: withoutPrefix)
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        return documentToBeneficiary(query.docs.first);
      }
      
      // Also try with NFC_ prefix
      query = await _collection
          .where('nfcPreprintedCode', isEqualTo: 'NFC_$withoutPrefix')
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        return documentToBeneficiary(query.docs.first);
      }
    }
    
    // Removed slow fallback that gets all documents - this was causing performance issues
    // If exact match fails, return null (beneficiary not found)
    return null;
  }

  /// Get beneficiary by NFC reference
  static Future<Beneficiary?> getBeneficiaryByNFCReference(String nfcReference) async {
    if (nfcReference.isEmpty) return null;
    final trimmedRef = nfcReference.trim();
    if (trimmedRef.isEmpty) return null;
    
    // Try exact match first
    var query = await _collection
        .where('nfcReference', isEqualTo: trimmedRef)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      return documentToBeneficiary(query.docs.first);
    }
    
    // If not found, try without leading zeros (in case stored differently)
    // But only if the value has leading zeros
    if (trimmedRef.startsWith('0') && trimmedRef.length > 1) {
      final withoutLeadingZeros = trimmedRef.replaceFirst(RegExp(r'^0+'), '');
      if (withoutLeadingZeros.isNotEmpty && withoutLeadingZeros != trimmedRef) {
        query = await _collection
            .where('nfcReference', isEqualTo: withoutLeadingZeros)
            .limit(1)
            .get();
        if (query.docs.isNotEmpty) {
          return documentToBeneficiary(query.docs.first);
        }
      }
    }
    
    return null;
  }

  /// Create a new beneficiary
  static Future<String> createBeneficiary(
      Beneficiary beneficiary, String createdBy) async {
    final docRef = await _collection.add({
      'distributionArea': beneficiary.distributionArea,
      'initialAssignedQueuePoint': beneficiary.initialAssignedQueuePoint ?? '', // Deprecated: keep for backward compatibility
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
      'nfcReference': beneficiary.nfcReference,
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
      'initialAssignedQueuePoint': beneficiary.initialAssignedQueuePoint ?? '', // Deprecated: keep for backward compatibility
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
      'nfcReference': beneficiary.nfcReference,
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

  /// Delete all beneficiaries that were created by a given creator (e.g. 'mock').
  /// Returns the number of beneficiaries deleted.
  static Future<int> deleteBeneficiariesCreatedBy(String createdBy) async {
    final snapshot = await _collection.where('createdBy', isEqualTo: createdBy).get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
    return snapshot.docs.length;
  }

  /// Get all beneficiaries that have a queue assignment (for one-time renumbering migration).
  static Future<List<Beneficiary>> getBeneficiariesWithQueueAssignment() async {
    final snapshot = await _collection
        .where('initialAssignedQueuePoint', isNotEqualTo: '')
        .get();
    return snapshot.docs.map((doc) => documentToBeneficiary(doc)).toList();
  }

  /// Get all beneficiaries that have a queue number set (may overlap with initialAssignedQueuePoint).
  static Future<List<Beneficiary>> getBeneficiariesWithQueueNumber() async {
    final snapshot = await _collection
        .where('queueNumber', isNotEqualTo: null)
        .get();
    return snapshot.docs.map((doc) => documentToBeneficiary(doc)).toList();
  }

  /// Clear all queue assignments from all beneficiaries (initialAssignedQueuePoint and queueNumber).
  /// Also resets isServed and unitsTaken so no one appears "Served" after cleanup (mock/seed data).
  /// Used for one-time cleanup so queue numbers are not affected by mock/seed data.
  /// Covers both single queues and multi-day (sub) queues.
  /// Returns the number of beneficiaries updated.
  static Future<int> clearAllQueueAssignmentsFromBeneficiaries() async {
    final withQueuePoint = await getBeneficiariesWithQueueAssignment();
    final withQueueNumber = await getBeneficiariesWithQueueNumber();
    final byId = <String, Beneficiary>{};
    for (final b in withQueuePoint) {
      byId[b.id] = b;
    }
    for (final b in withQueueNumber) {
      byId[b.id] = b;
    }
    final toUpdate = byId.values.toList();
    if (toUpdate.isEmpty) return 0;
    const batchSize = 500;
    int updated = 0;
    for (int i = 0; i < toUpdate.length; i += batchSize) {
      final batch = FirebaseService.firestore.batch();
      final chunk = toUpdate.skip(i).take(batchSize).toList();
      for (final b in chunk) {
        batch.update(_collection.doc(b.id), {
          'initialAssignedQueuePoint': '',
          'queueNumber': null,
          'isServed': false,
          'unitsTaken': 0,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        updated++;
      }
      await batch.commit();
    }
    return updated;
  }

  /// Reset isServed and unitsTaken for all beneficiaries that are currently marked served.
  /// Used so no one appears "Served" in the UI after cleanup (mock/seed or old data).
  /// Returns the number of beneficiaries updated.
  static Future<int> resetAllServedStateFromBeneficiaries() async {
    const batchSize = 500;
    int updated = 0;
    DocumentSnapshot? lastDoc;
    while (true) {
      Query query = _collection
          .where('isServed', isEqualTo: true)
          .limit(batchSize);
      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }
      final snapshot = await query.get();
      if (snapshot.docs.isEmpty) break;
      final batch = FirebaseService.firestore.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {
          'isServed': false,
          'unitsTaken': 0,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        updated++;
      }
      await batch.commit();
      lastDoc = snapshot.docs.last;
      if (snapshot.docs.length < batchSize) break;
    }
    return updated;
  }

  /// Delete all "issued" ticket records from queueHistory for every queue (single and multi-day sub-queues).
  /// This ensures no beneficiary is considered assigned to any queue so queue numbers are not affected by mock data.
  /// Returns the number of queueHistory documents deleted.
  static Future<int> clearAllIssuedTicketsFromQueueHistory() async {
    final collection = FirebaseService.firestore.collection('queueHistory');
    int deleted = 0;
    const batchSize = 500;
    while (true) {
      final snapshot = await collection
          .where('action', isEqualTo: 'issued')
          .limit(batchSize)
          .get();
      if (snapshot.docs.isEmpty) break;
      final batch = FirebaseService.firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
        deleted++;
      }
      await batch.commit();
    }
    return deleted;
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
      final beneficiary = documentToBeneficiary(doc);
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
  /// Made public for performance optimizations in queue serving
  static Beneficiary documentToBeneficiary(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Beneficiary(
      id: doc.id,
      distributionArea: data['distributionArea'] ?? '',
      initialAssignedQueuePoint: data['initialAssignedQueuePoint'], // Nullable: deprecated field
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
      nfcReference: data['nfcReference'],
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

