import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/firebase_service.dart';

/// Firebase Collections Setup Service
/// 
/// This service helps you set up the Firestore database structure.
/// Run this after Firebase is initialized in your app.
class FirebaseCollectionsSetup {
  /// Setup all collections with initial structure
  /// This creates sample documents to ensure collections exist
  /// Optimized to be non-blocking and faster
  static Future<void> setupAllCollections() async {
    try {
      // Skip connection test to speed up - collections will be created on first use anyway
      // Verify Firestore is accessible with a quick timeout
      final firestore = FirebaseService.firestore;
      
      // Quick connection check with timeout (non-blocking)
      try {
        await firestore
            .collection('_test')
            .doc('connection_test')
            .set({'test': true, 'timestamp': FieldValue.serverTimestamp()})
            .timeout(const Duration(seconds: 2));
        await firestore.collection('_test').doc('connection_test').delete();
        print('✅ Firestore connection verified');
      } catch (e) {
        print('⚠️ Firestore connection test skipped or failed (non-critical): $e');
        // Continue anyway - collections will be created on first use
      }
      
      // Initialize collections in parallel for faster setup
      // Collections are created automatically when first document is added
      // Run critical collections first, others in parallel
      await Future.wait([
        _setupRoles().catchError((e) {
          print('⚠️ Roles setup error (non-critical): $e');
          return null;
        }),
        _setupDistributionAreas().catchError((e) {
          print('⚠️ Distribution areas setup error (non-critical): $e');
          return null;
        }),
      ], eagerError: false);
      
      // Setup other collections in parallel (non-critical)
      await Future.wait([
        _setupQueues().catchError((e) {
          print('⚠️ Queues setup error (non-critical): $e');
          return null;
        }),
        _setupBeneficiaries().catchError((e) {
          print('⚠️ Beneficiaries setup error (non-critical): $e');
          return null;
        }),
        _setupAdmins().catchError((e) {
          print('⚠️ Admins setup error (non-critical): $e');
          return null;
        }),
        _setupVolunteers().catchError((e) {
          print('⚠️ Volunteers setup error (non-critical): $e');
          return null;
        }),
        _setupEntities().catchError((e) {
          print('⚠️ Entities setup error (non-critical): $e');
          return null;
        }),
        _setupQueueHistory().catchError((e) {
          print('⚠️ Queue history setup error (non-critical): $e');
          return null;
        }),
        _setupReports().catchError((e) {
          print('⚠️ Reports setup error (non-critical): $e');
          return null;
        }),
        _setupUnits().catchError((e) {
          print('⚠️ Units setup error (non-critical): $e');
          return null;
        }),
      ], eagerError: false);
      
    } catch (e, stackTrace) {
      print('⚠️ Error setting up collections (non-critical): $e');
      print('Stack trace: $stackTrace');
      print('💡 Collections will be created automatically on first use');
      // Don't rethrow - this is non-critical and shouldn't block the app
    }
  }

  static Future<void> _setupRoles() async {
    final collection = FirebaseService.firestore.collection('roles');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      // Create default roles
      final defaultRoles = [
        {
          'name': 'Super_Admin',
          'description': 'Super Administrator with full access to all features',
          'permissions': ['all'],
        },
        {
          'name': 'Admin',
          'description': 'Administrator with access to manage queues and beneficiaries',
          'permissions': ['manage_queues', 'manage_beneficiaries', 'view_reports'],
        },
        {
          'name': 'Q_Admin',
          'description': 'Queue Administrator with access to manage assigned queues',
          'permissions': ['manage_assigned_queues', 'view_assigned_beneficiaries'],
        },
      ];
      
      for (final roleData in defaultRoles) {
        await collection.add({
          'name': roleData['name'],
          'description': roleData['description'],
          'permissions': roleData['permissions'],
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupDistributionAreas() async {
    try {
      final collection = FirebaseService.firestore.collection('distributionAreas');
      
      // Check if collection already has data
      final existing = await collection.limit(1).get();
      if (existing.docs.isEmpty) {
        await collection.doc('sample_area').set({
          'country': 'Egypt',
          'governorate': 'Cairo',
          'city': 'Sample City',
          'areaName': 'Sample Queue Point',
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        // Collection already exists
      }
    } catch (e) {
      print('  ❌ Error setting up distributionAreas: $e');
      rethrow;
    }
  }

  static Future<void> _setupQueues() async {
    final collection = FirebaseService.firestore.collection('queues');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.doc('sample_queue').set({
        'name': 'Sample Queue',
        'queueManager': 'Admin',
        'country': 'Egypt',
        'governorate': 'Cairo',
        'city': 'Sample City',
        'queuePointName': 'Sample Queue Point',
        'distributionArea': 'sample_area',
        'queueType': 'Single Day',
        'fromDate': Timestamp.now(),
        'toDate': Timestamp.now(),
        'fromTime': {'hour': 8, 'minute': 0},
        'toTime': {'hour': 18, 'minute': 0},
        'unitName': 'Meals',
        'numberOfAvailableUnits': 100,
        'estimatedQueueSize': 80,
        'directServe': false,
        'priority': [],
        'status': 'active',
        'isStarted': false,
        'isCompleted': false,
        'isSuspended': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupBeneficiaries() async {
    final collection = FirebaseService.firestore.collection('beneficiaries');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.doc('sample_beneficiary').set({
        'distributionArea': 'sample_area',
        'initialAssignedQueuePoint': 'Sample Queue',
        'type': 'Normal',
        'gender': 'Male',
        'name': 'Sample Beneficiary',
        'idNumber': '12345678901',
        'isEntity': false,
        'numberOfUnits': '1',
        'status': 'Active',
        'isServed': false,
        'unitsTaken': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupAdmins() async {
    final collection = FirebaseService.firestore.collection('admins');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.doc('sample_admin').set({
        'country': 'Egypt',
        'governorate': 'Cairo',
        'city': 'Sample City',
        'distributionPoint': 'Sample Point',
        'fullName': 'Sample Admin',
        'mobile': '01000000000',
        'password': 'password',
        'notes': 'Sample admin account',
        'status': 'active',
        'isRequestedByGuest': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupVolunteers() async {
    final collection = FirebaseService.firestore.collection('volunteers');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.doc('sample_volunteer').set({
        'fullName': 'Sample Volunteer',
        'mobile': '01000000001',
        'password': 'password',
        'notes': 'Sample volunteer account',
        'distributionArea': 'sample_area',
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupEntities() async {
    final collection = FirebaseService.firestore.collection('entities');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.add({
        'name': 'UNHCR',
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupQueueHistory() async {
    final collection = FirebaseService.firestore.collection('queueHistory');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.add({
        'queueId': 'sample_queue',
        'beneficiaryId': 'sample_beneficiary',
        'action': 'issued',
        'queueNumber': 1,
        'performedBy': 'system',
        'performedAt': FieldValue.serverTimestamp(),
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupReports() async {
    final collection = FirebaseService.firestore.collection('reports');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.add({
        'type': 'daily',
        'title': 'Sample Report',
        'data': {
          'totalQueues': 1,
          'activeQueues': 1,
          'totalBeneficiaries': 1,
          'servedBeneficiaries': 0,
        },
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
    } else {
      // Collection already exists
    }
  }

  static Future<void> _setupUnits() async {
    final collection = FirebaseService.firestore.collection('units');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      // Create default units
      final defaultUnits = [
        {'name': 'Meals', 'description': 'Food meals', 'order': 1},
        {'name': 'Bags', 'description': 'Food bags', 'order': 2},
        {'name': 'Blankets', 'description': 'Blankets and covers', 'order': 3},
        {'name': 'Others', 'description': 'Other unit types', 'order': 99},
      ];
      
      for (final unitData in defaultUnits) {
        await collection.add({
          'name': unitData['name'],
          'description': unitData['description'],
          'isActive': true,
          'order': unitData['order'],
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } else {
      // Collection already exists
    }
  }

  /// Clean up sample documents (optional) – docs with createdBy == 'system'
  static Future<void> cleanupSampleData() async {
    print('Cleaning up sample data...');
    await cleanupAllMockAndSampleData();
    print('Sample data cleanup complete!');
  }

  /// Clean up all mock and sample data: known sample doc IDs, createdBy=='system', and mock beneficiaries (call BeneficiaryService separately).
  /// Returns a map of collection/category -> count of items removed.
  static Future<Map<String, int>> cleanupAllMockAndSampleData() async {
    final firestore = FirebaseService.firestore;
    final removed = <String, int>{};
    int total = 0;

    // 1) Delete known sample document IDs (some samples don't have createdBy)
    final knownSampleIds = <String, List<String>>{
      'distributionAreas': ['sample_area'],
      'queues': ['sample_queue'],
      'beneficiaries': ['sample_beneficiary'],
      'admins': ['sample_admin'],
      'volunteers': ['sample_volunteer'],
    };
    for (final entry in knownSampleIds.entries) {
      final col = firestore.collection(entry.key);
      int n = 0;
      for (final id in entry.value) {
        final ref = col.doc(id);
        final snap = await ref.get();
        if (snap.exists) {
          await ref.delete();
          n++;
        }
      }
      if (n > 0) {
        removed['${entry.key}(by id)'] = n;
        total += n;
      }
    }

    // 2) Delete any doc with createdBy == 'system' in these collections
    final collectionsWithCreatedBy = [
      'queues',
      'beneficiaries',
      'volunteers',
      'entities',
      'reports',
    ];
    for (final collectionName in collectionsWithCreatedBy) {
      final collection = firestore.collection(collectionName);
      final docs = await collection.where('createdBy', isEqualTo: 'system').get();
      for (final doc in docs.docs) {
        await doc.reference.delete();
      }
      if (docs.docs.isNotEmpty) {
        removed[collectionName] = docs.docs.length;
        total += docs.docs.length;
      }
    }

    // 3) queueHistory: delete sample-related (performedBy=='system' or queueId/beneficiaryId sample)
    final qhCol = firestore.collection('queueHistory');
    final toDelete = <DocumentReference>{};
    for (final query in [
      qhCol.where('performedBy', isEqualTo: 'system'),
      qhCol.where('queueId', isEqualTo: 'sample_queue'),
      qhCol.where('beneficiaryId', isEqualTo: 'sample_beneficiary'),
    ]) {
      final snapshot = await query.get();
      for (final doc in snapshot.docs) {
        toDelete.add(doc.reference);
      }
    }
    for (final ref in toDelete) {
      await ref.delete();
    }
    if (toDelete.isNotEmpty) {
      removed['queueHistory'] = toDelete.length;
      total += toDelete.length;
    }

    if (total > 0) {
      print('  ✓ Sample/schema data removed: $total document(s) across ${removed.length} collection(s)');
    }
    return removed;
  }

  /// Delete all documents in a collection (batch delete, supports large collections).
  static Future<int> _clearCollection(String collectionName) async {
    final firestore = FirebaseService.firestore;
    final collection = firestore.collection(collectionName);
    const batchSize = 500;
    int deleted = 0;
    while (true) {
      final snapshot = await collection.limit(batchSize).get();
      if (snapshot.docs.isEmpty) break;
      final batch = firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      deleted += snapshot.docs.length;
      if (snapshot.docs.length < batchSize) break;
    }
    return deleted;
  }

  /// Clear all documents from servingTransactions and queueHistory.
  /// Returns map with 'servingTransactions' and 'queueHistory' counts.
  static Future<Map<String, int>> clearServingAndQueueHistoryCollections() async {
    final result = <String, int>{};
    result['servingTransactions'] = await _clearCollection('servingTransactions');
    result['queueHistory'] = await _clearCollection('queueHistory');
    return result;
  }
}

