import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// Volunteer Model (Q Co-admin)
class Volunteer {
  final String id;
  final String fullName;
  final String mobile;
  final String? email;
  final String notes;
  final String? reference;
  final String distributionArea;
  final String status;
  final DateTime createdAt;

  Volunteer({
    required this.id,
    required this.fullName,
    required this.mobile,
    this.email,
    required this.notes,
    this.reference,
    required this.distributionArea,
    required this.status,
    required this.createdAt,
  });
}

/// Service for managing Volunteers (Q Co-admins)
class VolunteerService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('volunteers');

  /// Get all volunteers
  static Stream<List<Volunteer>> getAllVolunteers() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => _documentToVolunteer(doc))
            .toList());
  }

  /// Get volunteers by distribution area
  static Stream<List<Volunteer>> getVolunteersByArea(String areaId) {
    return _collection
        .where('distributionArea', isEqualTo: areaId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => _documentToVolunteer(doc))
            .toList());
  }

  /// Get volunteer by ID
  static Future<Volunteer?> getVolunteerById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToVolunteer(doc);
    }
    return null;
  }

  /// Create a new volunteer
  static Future<String> createVolunteer(
      Volunteer volunteer, String createdBy) async {
    final docRef = await _collection.add({
      'fullName': volunteer.fullName,
      'mobile': volunteer.mobile,
      'password': volunteer.mobile, // In real app, hash the password
      'email': volunteer.email,
      'notes': volunteer.notes,
      'reference': volunteer.reference,
      'distributionArea': volunteer.distributionArea,
      'status': volunteer.status,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'createdBy': createdBy,
    });
    return docRef.id;
  }

  /// Update volunteer
  static Future<void> updateVolunteer(String id, Volunteer volunteer) async {
    await _collection.doc(id).update({
      'fullName': volunteer.fullName,
      'mobile': volunteer.mobile,
      'email': volunteer.email,
      'notes': volunteer.notes,
      'reference': volunteer.reference,
      'distributionArea': volunteer.distributionArea,
      'status': volunteer.status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete volunteer
  static Future<void> deleteVolunteer(String id) async {
    await _collection.doc(id).delete();
  }

  /// Convert Firestore document to Volunteer model
  static Volunteer _documentToVolunteer(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Volunteer(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      mobile: data['mobile'] ?? '',
      email: data['email'],
      notes: data['notes'] ?? '',
      reference: data['reference'],
      distributionArea: data['distributionArea'] ?? '',
      status: data['status'] ?? 'active',
      createdAt: data['createdAt'] != null
          ? FirebaseService.timestampToDateTime(data['createdAt'] as Timestamp)
          : DateTime.now(),
    );
  }
}

