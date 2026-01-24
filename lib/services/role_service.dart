import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// Role Model
class Role {
  final String id;
  final String name; // 'Super_Admin', 'Admin', 'Q_Admin'
  final String description;
  final List<String> permissions;
  final DateTime createdAt;

  Role({
    required this.id,
    required this.name,
    required this.description,
    this.permissions = const [],
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'permissions': permissions,
      'createdAt': FirebaseService.dateTimeToTimestamp(createdAt),
    };
  }

  static Role fromMap(String id, Map<String, dynamic> data) {
    return Role(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      permissions: List<String>.from(data['permissions'] ?? []),
      createdAt: data['createdAt'] != null
          ? FirebaseService.timestampToDateTime(data['createdAt'] as Timestamp)
          : DateTime.now(),
    );
  }
}

/// Service for managing Roles
class RoleService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('roles');

  /// Initialize default roles if they don't exist
  static Future<void> initializeDefaultRoles() async {
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

    for (var roleData in defaultRoles) {
      // Check if role already exists
      final query = await _collection
          .where('name', isEqualTo: roleData['name'])
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        // Role doesn't exist, create it
        await _collection.add({
          'name': roleData['name'],
          'description': roleData['description'],
          'permissions': roleData['permissions'],
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('✅ Created default role: ${roleData['name']}');
      }
    }
  }

  /// Get all roles
  static Stream<List<Role>> getAllRoles() {
    return _collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Role.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList());
  }

  /// Get role by ID
  static Future<Role?> getRoleById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Role.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  /// Get role by name
  static Future<Role?> getRoleByName(String name) async {
    final query = await _collection
        .where('name', isEqualTo: name)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return Role.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  /// Get role ID by name
  static Future<String?> getRoleIdByName(String name) async {
    final role = await getRoleByName(name);
    return role?.id;
  }

  /// Create a new role
  static Future<String> createRole(Role role) async {
    final docRef = await _collection.add(role.toMap());
    return docRef.id;
  }

  /// Update role
  static Future<void> updateRole(String id, Role role) async {
    await _collection.doc(id).update(role.toMap());
  }

  /// Delete role
  static Future<void> deleteRole(String id) async {
    await _collection.doc(id).delete();
  }
}

