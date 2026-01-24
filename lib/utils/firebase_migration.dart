import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../services/firebase_service.dart';

/// Migration utility to push existing in-memory data to Firebase
/// Use this to migrate your current app data to Firestore
class FirebaseMigration {
  /// Migrate distribution areas to Firestore
  static Future<void> migrateDistributionAreas(
      List<DistributionArea> areas) async {
    print('Migrating ${areas.length} distribution areas...');
    
    final batch = FirebaseService.firestore.batch();
    int count = 0;
    
    for (final area in areas) {
      final docRef = FirebaseService.firestore
          .collection('distributionAreas')
          .doc(area.id);
      
      batch.set(docRef, {
        'country': area.country,
        'governorate': area.governorate,
        'city': area.city,
        'areaName': area.areaName,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      count++;
      
      // Firestore batch writes are limited to 500 operations
      if (count % 500 == 0) {
        await batch.commit();
        print('Migrated $count areas...');
      }
    }
    
    if (count % 500 != 0) {
      await batch.commit();
    }
    
    print('Successfully migrated $count distribution areas!');
  }

  /// Migrate queues to Firestore
  static Future<void> migrateQueues(List<Queue> queues, String createdBy) async {
    print('Migrating ${queues.length} queues...');
    
    final batch = FirebaseService.firestore.batch();
    int count = 0;
    
    for (final queue in queues) {
      final docRef = FirebaseService.firestore.collection('queues').doc();
      
      batch.set(docRef, {
        'name': queue.name,
        'queueManager': queue.queueManager,
        'country': queue.country,
        'governorate': queue.governorate,
        'city': queue.city,
        'queuePointName': queue.queuePointName,
        'distributionArea': queue.distributionArea,
        'queueType': queue.queueType,
        'fromDate': FirebaseService.dateTimeToTimestamp(queue.fromDate),
        'toDate': FirebaseService.dateTimeToTimestamp(queue.toDate),
        'fromTime': FirebaseService.timeOfDayToMap(queue.fromTime),
        'toTime': FirebaseService.timeOfDayToMap(queue.toTime),
        'unitName': queue.unitName,
        'customUnitName': queue.unitName == 'Others' ? queue.unitName : null,
        'numberOfAvailableUnits': queue.numberOfAvailableUnits,
        'estimatedQueueSize': queue.estimatedQueueSize,
        'directServe': queue.directServe,
        'priority': queue.priority,
        'status': queue.status,
        'subtitle': queue.subtitle,
        'isStarted': queue.isStarted,
        'isCompleted': queue.isCompleted,
        'isSuspended': queue.isSuspended,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'createdBy': createdBy,
      });
      
      count++;
      
      if (count % 500 == 0) {
        await batch.commit();
        print('Migrated $count queues...');
      }
    }
    
    if (count % 500 != 0) {
      await batch.commit();
    }
    
    print('Successfully migrated $count queues!');
  }

  /// Migrate beneficiaries to Firestore
  static Future<void> migrateBeneficiaries(
      List<Beneficiary> beneficiaries, String createdBy) async {
    print('Migrating ${beneficiaries.length} beneficiaries...');
    
    final batch = FirebaseService.firestore.batch();
    int count = 0;
    
    for (final beneficiary in beneficiaries) {
      final docRef = FirebaseService.firestore
          .collection('beneficiaries')
          .doc(beneficiary.id);
      
      batch.set(docRef, {
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
      
      count++;
      
      if (count % 500 == 0) {
        await batch.commit();
        print('Migrated $count beneficiaries...');
      }
    }
    
    if (count % 500 != 0) {
      await batch.commit();
    }
    
    print('Successfully migrated $count beneficiaries!');
  }

  /// Migrate admins to Firestore
  static Future<void> migrateAdmins(List<Admin> admins) async {
    print('Migrating ${admins.length} admins...');
    
    final batch = FirebaseService.firestore.batch();
    int count = 0;
    
    for (final admin in admins) {
      final docRef = FirebaseService.firestore.collection('admins').doc(admin.id);
      
      batch.set(docRef, {
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
        'status': admin.status,
        'isRequestedByGuest': admin.isRequestedByGuest,
        'createdAt': FirebaseService.dateTimeToTimestamp(admin.createdAt),
        'updatedAt': FieldValue.serverTimestamp(),
        'approvedBy': null,
        'approvedAt': null,
      });
      
      count++;
      
      if (count % 500 == 0) {
        await batch.commit();
        print('Migrated $count admins...');
      }
    }
    
    if (count % 500 != 0) {
      await batch.commit();
    }
    
    print('Successfully migrated $count admins!');
  }

  /// Migrate all data at once
  static Future<void> migrateAllData({
    required List<DistributionArea> areas,
    required List<Queue> queues,
    required List<Beneficiary> beneficiaries,
    required List<Admin> admins,
    required String createdBy,
  }) async {
    print('Starting full data migration...');
    
    try {
      await migrateDistributionAreas(areas);
      await migrateQueues(queues, createdBy);
      await migrateBeneficiaries(beneficiaries, createdBy);
      await migrateAdmins(admins);
      
      print('Full data migration completed successfully!');
    } catch (e) {
      print('Error during migration: $e');
      rethrow;
    }
  }
}

