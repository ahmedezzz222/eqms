import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eqmsapp/main.dart';
import 'firebase_service.dart';

/// Service for managing serving transactions
/// This collection stores all serving transactions with references to queues and beneficiaries
class ServingTransactionService {
  static final CollectionReference _collection = 
      FirebaseService.firestore.collection('servingTransactions');

  /// Create a serving transaction record
  /// This is called when a beneficiary is served in a queue
  static Future<String> createServingTransaction({
    required String queueId, // Queue document ID
    required String queueName, // Queue name
    required String? dayQueueName, // Day-specific queue name for multi-day queues
    required String beneficiaryId, // Beneficiary document ID
    required String beneficiaryName, // Beneficiary name
    required String beneficiaryIdNumber, // Beneficiary ID number
    int? queueNumber, // Queue number assigned to beneficiary
    required int unitsTaken, // Units taken in this transaction
    required int totalUnitsTaken, // Total units taken by beneficiary (cumulative)
    required String unitName, // Unit name (Meals, Bags, etc.)
    required String servedBy, // Admin ID who served
    String? servedByName, // Admin full name
    required bool withoutTicket, // Whether served without ticket
    String? distributionArea, // Distribution area ID
    String? servingOption, // Serving option used (queueOrder, grace5, etc.)
  }) async {
    try {
      final docRef = await _collection.add({
        // Queue references
        'queueId': queueId,
        'queueName': queueName,
        'dayQueueName': dayQueueName ?? queueName, // Day-specific queue name for multi-day
        
        // Beneficiary references
        'beneficiaryId': beneficiaryId,
        'beneficiaryName': beneficiaryName,
        'beneficiaryIdNumber': beneficiaryIdNumber,
        'distributionArea': distributionArea,
        
        // Serving details
        'queueNumber': queueNumber,
        'unitsTaken': unitsTaken, // Units taken in this transaction
        'totalUnitsTaken': totalUnitsTaken, // Total units taken (cumulative)
        'unitName': unitName,
        'withoutTicket': withoutTicket,
        'servingOption': servingOption, // Serving option used
        
        // Metadata
        'servedAt': FieldValue.serverTimestamp(),
        'servedBy': servedBy, // Admin ID
        'servedByName': servedByName, // Admin full name
        
        // Timestamps
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      print('✅ Created serving transaction: ${docRef.id} for beneficiary $beneficiaryName');
      return docRef.id;
    } catch (e) {
      print('❌ Error creating serving transaction: $e');
      rethrow;
    }
  }

  /// Get all serving transactions for a specific queue
  static Stream<List<Map<String, dynamic>>> getServingTransactionsByQueue(String queueName) {
    return _collection
        .where('queueName', isEqualTo: queueName)
        .orderBy('servedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            ...data,
          };
        }).toList());
  }

  /// Get all serving transactions for a specific day queue (for multi-day queues)
  static Stream<List<Map<String, dynamic>>> getServingTransactionsByDayQueue(String dayQueueName) {
    return _collection
        .where('dayQueueName', isEqualTo: dayQueueName)
        .orderBy('servedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return {
            'id': doc.id,
            ...data,
          };
        }).toList());
  }

  /// Get all serving transactions for a specific beneficiary
  static Future<List<Map<String, dynamic>>> getServingTransactionsByBeneficiary(String beneficiaryId) async {
    try {
      final snapshot = await _collection
          .where('beneficiaryId', isEqualTo: beneficiaryId)
          .orderBy('servedAt', descending: true)
          .get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
    } catch (e) {
      print('❌ Error getting serving transactions by beneficiary: $e');
      return [];
    }
  }

  /// Get total units served for a queue
  static Future<int> getTotalUnitsServedForQueue(String queueName) async {
    try {
      final snapshot = await _collection
          .where('queueName', isEqualTo: queueName)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final unitsTaken = data['unitsTaken'] as int? ?? 0;
        total += unitsTaken;
      }
      
      return total;
    } catch (e) {
      print('❌ Error getting total units served: $e');
      return 0;
    }
  }

  /// Get total units served for a day queue (for multi-day queues)
  static Future<int> getTotalUnitsServedForDayQueue(String dayQueueName) async {
    try {
      final snapshot = await _collection
          .where('dayQueueName', isEqualTo: dayQueueName)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final unitsTaken = data['unitsTaken'] as int? ?? 0;
        total += unitsTaken;
      }
      
      return total;
    } catch (e) {
      print('❌ Error getting total units served for day queue: $e');
      return 0;
    }
  }

  /// Get units served by a beneficiary in a specific queue
  static Future<int> getUnitsServedByBeneficiaryInQueue(String beneficiaryId, String queueName) async {
    try {
      final snapshot = await _collection
          .where('beneficiaryId', isEqualTo: beneficiaryId)
          .where('queueName', isEqualTo: queueName)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final unitsTaken = data['unitsTaken'] as int? ?? 0;
        total += unitsTaken;
      }
      
      return total;
    } catch (e) {
      print('❌ Error getting units served by beneficiary in queue: $e');
      return 0;
    }
  }

  /// Get units served by a beneficiary in a specific day queue (for multi-day queues)
  static Future<int> getUnitsServedByBeneficiaryInDayQueue(String beneficiaryId, String dayQueueName) async {
    try {
      final snapshot = await _collection
          .where('beneficiaryId', isEqualTo: beneficiaryId)
          .where('dayQueueName', isEqualTo: dayQueueName)
          .get();
      
      int total = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final unitsTaken = data['unitsTaken'] as int? ?? 0;
        total += unitsTaken;
      }
      
      return total;
    } catch (e) {
      print('❌ Error getting units served by beneficiary in day queue: $e');
      return 0;
    }
  }

  /// Check if beneficiary was served today in another queue with the same unit type
  static Future<bool> wasBeneficiaryServedTodayInOtherQueue(
    String beneficiaryId,
    String currentQueueName,
    String unitName,
  ) async {
    try {
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      final todayEnd = todayStart.add(const Duration(days: 1));
      
      final snapshot = await _collection
          .where('beneficiaryId', isEqualTo: beneficiaryId)
          .where('unitName', isEqualTo: unitName)
          .where('servedAt', isGreaterThanOrEqualTo: FirebaseService.dateTimeToTimestamp(todayStart))
          .where('servedAt', isLessThan: FirebaseService.dateTimeToTimestamp(todayEnd))
          .get();
      
      // Check if any transaction is from a different queue
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final servedQueueName = data['queueName'] as String?;
        if (servedQueueName != null && servedQueueName != currentQueueName) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print('❌ Error checking if beneficiary was served today: $e');
      return false;
    }
  }

  /// Delete a serving transaction (for corrections/rollbacks)
  static Future<void> deleteServingTransaction(String transactionId) async {
    try {
      await _collection.doc(transactionId).delete();
      print('✅ Deleted serving transaction: $transactionId');
    } catch (e) {
      print('❌ Error deleting serving transaction: $e');
      rethrow;
    }
  }
}
