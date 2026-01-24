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
    print('🚀 Setting up Firestore collections in background...');
    print('📦 Project: et3am-ca94c');
    
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
      
      print('✅ All collections setup complete!');
      print('💡 You can now delete the sample documents from Firebase Console if needed.');
      print('🔗 View in Console: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore');
    } catch (e, stackTrace) {
      print('⚠️ Error setting up collections (non-critical): $e');
      print('Stack trace: $stackTrace');
      print('💡 Collections will be created automatically on first use');
      // Don't rethrow - this is non-critical and shouldn't block the app
    }
  }

  static Future<void> _setupRoles() async {
    print('Setting up roles collection...');
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
      print('  ✓ Created default roles');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupDistributionAreas() async {
    try {
      print('Setting up distributionAreas collection...');
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
        print('  ✅ Created sample distribution area');
      } else {
        print('  ✓ Collection already exists (${existing.docs.length} documents)');
      }
    } catch (e) {
      print('  ❌ Error setting up distributionAreas: $e');
      rethrow;
    }
  }

  static Future<void> _setupQueues() async {
    print('Setting up queues collection...');
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
      print('  ✓ Created sample queue');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupBeneficiaries() async {
    print('Setting up beneficiaries collection...');
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
      print('  ✓ Created sample beneficiary');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupAdmins() async {
    print('Setting up admins collection...');
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
      print('  ✓ Created sample admin');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupVolunteers() async {
    print('Setting up volunteers collection...');
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
      print('  ✓ Created sample volunteer');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupEntities() async {
    print('Setting up entities collection...');
    final collection = FirebaseService.firestore.collection('entities');
    
    final existing = await collection.limit(1).get();
    if (existing.docs.isEmpty) {
      await collection.add({
        'name': 'UNHCR',
        'createdAt': FieldValue.serverTimestamp(),
        'createdBy': 'system',
      });
      print('  ✓ Created sample entity');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupQueueHistory() async {
    print('Setting up queueHistory collection...');
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
      print('  ✓ Created sample queue history');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupReports() async {
    print('Setting up reports collection...');
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
      print('  ✓ Created sample report');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupUnits() async {
    print('Setting up units collection...');
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
      print('  ✓ Created default units');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  /// Clean up sample documents (optional)
  static Future<void> cleanupSampleData() async {
    print('Cleaning up sample data...');
    
    final collections = [
      'distributionAreas',
      'queues',
      'beneficiaries',
      'admins',
      'volunteers',
      'entities',
      'queueHistory',
      'reports',
      'units',
    ];

    for (final collectionName in collections) {
      final collection = FirebaseService.firestore.collection(collectionName);
      final docs = await collection.where('createdBy', isEqualTo: 'system').get();
      
      for (final doc in docs.docs) {
        await doc.reference.delete();
      }
      
      print('  ✓ Cleaned $collectionName');
    }
    
    print('Sample data cleanup complete!');
  }
}

