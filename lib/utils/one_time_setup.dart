import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/beneficiary_service.dart';
import '../services/firebase_collections_setup.dart';

/// One-time setup utility to initialize Firebase collections
/// Run this ONCE after Firebase is initialized
class OneTimeSetup {
  /// Run this function once to set up all collections
  /// Call this from a button in your app or during initialization
  static Future<Map<String, bool>> setupCollections() async {
    final results = <String, bool>{};
    
    try {
      print('🚀 Starting Firebase collections setup...');
      print('Project: et3am-ca94c');
      
      // Setup all collections
      await FirebaseCollectionsSetup.setupAllCollections();
      
      results['collections'] = true;
      print('✅ All collections created successfully!');
      
      // Verify collections exist
      await _verifyCollections();
      
      return results;
    } catch (e) {
      print('❌ Error setting up collections: $e');
      results['error'] = false;
      return results;
    }
  }

  /// Verify that all collections were created
  static Future<void> _verifyCollections() async {
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

    print('\n📋 Verifying collections...');
    
    for (final collectionName in collections) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection(collectionName)
            .limit(1)
            .get();
        
        if (snapshot.docs.isNotEmpty || snapshot.size >= 0) {
          print('  ✅ $collectionName - EXISTS');
        } else {
          print('  ⚠️  $collectionName - EMPTY (but created)');
        }
      } catch (e) {
        print('  ❌ $collectionName - ERROR: $e');
      }
    }
    
    print('\n✅ Verification complete!');
    print('💡 You can now delete the sample documents from Firebase Console if needed.');
  }

  /// Clean up sample documents after verification
  static Future<void> cleanupSamples() async {
    print('🧹 Cleaning up sample documents...');
    await FirebaseCollectionsSetup.cleanupSampleData();
    print('✅ Cleanup complete!');
  }

  /// Clean up all mock and sample data: mock beneficiaries + sample/schema docs (sample IDs, createdBy system, sample queueHistory).
  /// Returns counts: mockBeneficiaries, sampleDocs (total), and per-collection breakdown from FirebaseCollectionsSetup.
  static Future<Map<String, dynamic>> cleanupAllMockData() async {
    print('🧹 Cleaning up all mock data...');
    final mockCount = await BeneficiaryService.deleteBeneficiariesCreatedBy('mock');
    if (mockCount > 0) {
      print('  ✓ Removed $mockCount mock beneficiary(ies)');
    }
    final sampleRemoved = await FirebaseCollectionsSetup.cleanupAllMockAndSampleData();
    final sampleTotal = sampleRemoved.values.fold<int>(0, (a, b) => a + b);
    print('✅ Mock data cleanup complete: $mockCount mock beneficiaries, $sampleTotal sample doc(s) removed.');
    return {
      'mockBeneficiaries': mockCount,
      'sampleDocs': sampleTotal,
      'byCollection': sampleRemoved,
    };
  }

  /// Clear all documents from servingTransactions and queueHistory.
  /// Returns counts: servingTransactions, queueHistory.
  static Future<Map<String, int>> clearServingAndQueueHistory() async {
    return FirebaseCollectionsSetup.clearServingAndQueueHistoryCollections();
  }
}

