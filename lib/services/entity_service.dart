import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// Service for managing Entities
class EntityService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('entities');

  /// Get all entities
  static Stream<List<String>> getAllEntities() {
    return _collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String)
            .toList());
  }

  /// Create a new entity
  static Future<String> createEntity(String name, String createdBy) async {
    final docRef = await _collection.add({
      'name': name,
      'createdAt': FieldValue.serverTimestamp(),
      'createdBy': createdBy,
    });
    return docRef.id;
  }

  /// Delete entity
  static Future<void> deleteEntity(String id) async {
    await _collection.doc(id).delete();
  }
}

