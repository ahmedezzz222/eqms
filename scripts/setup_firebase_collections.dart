/// Firebase Collections Setup Script
/// 
/// This script helps you set up the Firestore database structure.
/// Run this after Firebase is initialized in your app.
/// 
/// Usage:
/// 1. Make sure Firebase is initialized in your app
/// 2. Call the setup functions from a button or during app initialization
/// 3. Or use Firebase Console to create collections manually

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseCollectionsSetup {
  /// Setup all collections with initial structure
  /// This creates sample documents to ensure collections exist
  static Future<void> setupAllCollections() async {
    print('Setting up Firestore collections...');
    
    try {
      // Initialize collections by creating a sample document in each
      // Collections are created automatically when first document is added
      
      await _setupDistributionAreas();
      await _setupQueues();
      await _setupBeneficiaries();
      await _setupAdmins();
      await _setupVolunteers();
      await _setupEntities();
      await _setupQueueHistory();
      await _setupReports();
      
      print('✓ All collections setup complete!');
      print('You can now delete the sample documents from Firebase Console if needed.');
    } catch (e) {
      print('Error setting up collections: $e');
      rethrow;
    }
  }

  static Future<void> _setupDistributionAreas() async {
    print('Setting up distributionAreas collection...');
    final collection = FirebaseFirestore.instance.collection('distributionAreas');
    
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
      print('  ✓ Created sample distribution area');
    } else {
      print('  ✓ Collection already exists');
    }
  }

  static Future<void> _setupQueues() async {
    print('Setting up queues collection...');
    final collection = FirebaseFirestore.instance.collection('queues');
    
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
    final collection = FirebaseFirestore.instance.collection('beneficiaries');
    
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
    final collection = FirebaseFirestore.instance.collection('admins');
    
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
    final collection = FirebaseFirestore.instance.collection('volunteers');
    
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
    final collection = FirebaseFirestore.instance.collection('entities');
    
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
    final collection = FirebaseFirestore.instance.collection('queueHistory');
    
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
    final collection = FirebaseFirestore.instance.collection('reports');
    
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
    ];

    for (final collectionName in collections) {
      final collection = FirebaseFirestore.instance.collection(collectionName);
      final docs = await collection.where('createdBy', isEqualTo: 'system').get();
      
      for (final doc in docs.docs) {
        await doc.reference.delete();
      }
      
      print('  ✓ Cleaned $collectionName');
    }
    
    print('Sample data cleanup complete!');
  }
}

