import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// Unit Model
class Unit {
  final String id;
  final String name;
  final String? description;
  final bool isActive;
  final int? order;
  final DateTime createdAt;
  final DateTime updatedAt;

  Unit({
    required this.id,
    required this.name,
    this.description,
    this.isActive = true,
    this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'isActive': isActive,
      'order': order,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Unit.fromMap(String id, Map<String, dynamic> map) {
    return Unit(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
      isActive: map['isActive'] ?? true,
      order: map['order'],
      createdAt: map['createdAt'] != null
          ? FirebaseService.timestampToDateTime(map['createdAt'] as Timestamp)
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? FirebaseService.timestampToDateTime(map['updatedAt'] as Timestamp)
          : DateTime.now(),
    );
  }
}

/// Service for managing Units
class UnitService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('units');

  /// Get all active units
  static Stream<List<Unit>> getAllUnits() {
    try {
      return _collection
          .where('isActive', isEqualTo: true)
          .snapshots()
          .map((snapshot) {
            print('📦 Fetched ${snapshot.docs.length} units from Firestore');
            final units = snapshot.docs
                .map((doc) {
                  try {
                    return Unit.fromMap(doc.id, doc.data() as Map<String, dynamic>);
                  } catch (e) {
                    print('❌ Error parsing unit ${doc.id}: $e');
                    print('   Data: ${doc.data()}');
                    return null;
                  }
                })
                .whereType<Unit>()
                .toList();
            
            print('✅ Parsed ${units.length} units: ${units.map((u) => u.name).join(", ")}');
            
            // Sort manually to avoid composite index requirement
            units.sort((a, b) {
              final orderA = a.order ?? 999;
              final orderB = b.order ?? 999;
              return orderA.compareTo(orderB);
            });
            return units;
          })
          .handleError((error) {
            print('❌ Error fetching units: $error');
            print('   Error type: ${error.runtimeType}');
            // Return empty list on error, fallback will be used in UI
            return <Unit>[];
          });
    } catch (e) {
      print('❌ Error creating stream for units: $e');
      return Stream.value(<Unit>[]);
    }
  }

  /// Get all units (including inactive)
  static Stream<List<Unit>> getAllUnitsIncludingInactive() {
    try {
      return _collection
          .snapshots()
          .map((snapshot) {
            final units = snapshot.docs
                .map((doc) => Unit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
                .toList();
            // Sort manually to avoid index requirement
            units.sort((a, b) {
              final orderA = a.order ?? 999;
              final orderB = b.order ?? 999;
              return orderA.compareTo(orderB);
            });
            return units;
          })
          .handleError((error) {
            print('Error fetching units: $error');
            return <Unit>[];
          });
    } catch (e) {
      print('Error creating stream for units: $e');
      return Stream.value(<Unit>[]);
    }
  }

  /// Get unit by ID
  static Future<Unit?> getUnitById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (doc.exists) {
        return Unit.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting unit by ID: $e');
      return null;
    }
  }

  /// Create a new unit
  static Future<String> createUnit(Unit unit) async {
    try {
      final docRef = await _collection.add({
        'name': unit.name,
        'description': unit.description,
        'isActive': unit.isActive,
        'order': unit.order,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print('Error creating unit: $e');
      rethrow;
    }
  }

  /// Update a unit
  static Future<void> updateUnit(String id, Unit unit) async {
    try {
      await _collection.doc(id).update({
        'name': unit.name,
        'description': unit.description,
        'isActive': unit.isActive,
        'order': unit.order,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error updating unit: $e');
      rethrow;
    }
  }

  /// Delete a unit (soft delete by setting isActive to false)
  static Future<void> deleteUnit(String id) async {
    try {
      await _collection.doc(id).update({
        'isActive': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error deleting unit: $e');
      rethrow;
    }
  }

  /// Hard delete a unit
  static Future<void> hardDeleteUnit(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      print('Error hard deleting unit: $e');
      rethrow;
    }
  }
}

