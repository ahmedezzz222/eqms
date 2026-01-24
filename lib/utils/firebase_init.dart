import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/firebase_service.dart';
import '../services/distribution_area_service.dart';
import '../main.dart';

/// Utility class to initialize Firebase database structure
/// Run this once to set up your database
class FirebaseInit {
  /// Initialize database with sample data (optional)
  /// Call this after Firebase.initializeApp() in main.dart
  static Future<void> initializeDatabase({bool seedSampleData = false}) async {
    try {
      print('Initializing Firebase database...');
      
      // Create indexes will be created automatically when queries are made
      // Or you can create them manually in Firebase Console
      
      if (seedSampleData) {
        await _seedSampleData();
      }
      
      print('Firebase database initialized successfully!');
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  /// Seed database with sample data for testing
  static Future<void> _seedSampleData() async {
    print('Seeding sample data...');
    
    try {
      // Create sample distribution areas
      final area1 = DistributionArea(
        id: 'area_1',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Nasr City',
        areaName: 'Nasr City Queue Point',
      );
      
      final area2 = DistributionArea(
        id: 'area_2',
        country: 'Egypt',
        governorate: 'Alexandria',
        city: 'Alexandria',
        areaName: 'Alexandria Queue Point',
      );
      
      final area3 = DistributionArea(
        id: 'area_3',
        country: 'Egypt',
        governorate: 'Giza',
        city: 'Giza',
        areaName: 'Giza Queue Point',
      );

      // Check if areas already exist
      final existingAreas = await FirebaseService.firestore
          .collection('distributionAreas')
          .limit(1)
          .get();
      
      if (existingAreas.docs.isEmpty) {
        await FirebaseService.firestore
            .collection('distributionAreas')
            .doc(area1.id)
            .set({
          'country': area1.country,
          'governorate': area1.governorate,
          'city': area1.city,
          'areaName': area1.areaName,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        await FirebaseService.firestore
            .collection('distributionAreas')
            .doc(area2.id)
            .set({
          'country': area2.country,
          'governorate': area2.governorate,
          'city': area2.city,
          'areaName': area2.areaName,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        await FirebaseService.firestore
            .collection('distributionAreas')
            .doc(area3.id)
            .set({
          'country': area3.country,
          'governorate': area3.governorate,
          'city': area3.city,
          'areaName': area3.areaName,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        print('Created 3 sample distribution areas');
      } else {
        print('Distribution areas already exist, skipping...');
      }

      // Create sample entities
      final entities = ['UNHCR', 'Red Crescent', 'Local NGO', 'Government'];
      final existingEntities = await FirebaseService.firestore
          .collection('entities')
          .limit(1)
          .get();
      
      if (existingEntities.docs.isEmpty) {
        for (final entityName in entities) {
          await FirebaseService.firestore.collection('entities').add({
            'name': entityName,
            'createdAt': FieldValue.serverTimestamp(),
            'createdBy': 'system',
          });
        }
        print('Created ${entities.length} sample entities');
      } else {
        print('Entities already exist, skipping...');
      }

      print('Sample data seeded successfully!');
    } catch (e) {
      print('Error seeding sample data: $e');
      // Don't throw, just log the error
    }
  }

  /// Create Firestore indexes programmatically
  /// Note: Most indexes need to be created in Firebase Console
  /// This is just for reference
  static Future<void> createIndexes() async {
    print('Note: Firestore indexes should be created in Firebase Console.');
    print('Firebase will prompt you to create indexes when needed.');
    print('Or you can create them manually at:');
    print('https://console.firebase.google.com/project/YOUR_PROJECT/firestore/indexes');
  }

  /// Verify database structure
  static Future<void> verifyStructure() async {
    print('Verifying database structure...');
    
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

    for (final collection in collections) {
      try {
        final snapshot = await FirebaseService.firestore
            .collection(collection)
            .limit(1)
            .get();
        print('✓ Collection "$collection" exists');
      } catch (e) {
        print('✗ Collection "$collection" error: $e');
      }
    }
    
    print('Database structure verification complete!');
  }
}

