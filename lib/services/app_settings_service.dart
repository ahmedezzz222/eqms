import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_service.dart';

/// Service for managing app settings
class AppSettingsService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('appSettings');

  /// Get setting value by key
  static Future<bool> getSetting(String key, {bool defaultValue = true}) async {
    try {
      final doc = await _collection.doc(key).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['value'] as bool? ?? defaultValue;
      }
      // If setting doesn't exist, create it with default value
      await _collection.doc(key).set({
        'value': defaultValue,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      return defaultValue;
    } catch (e) {
      print('Error getting setting $key: $e');
      return defaultValue;
    }
  }

  /// Get setting value as stream
  static Stream<bool> getSettingStream(String key, {bool defaultValue = true}) {
    return _collection.doc(key).snapshots().map((doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['value'] as bool? ?? defaultValue;
      }
      return defaultValue;
    });
  }

  /// Set setting value
  static Future<void> setSetting(String key, bool value) async {
    try {
      await _collection.doc(key).set({
        'value': value,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error setting setting $key: $e');
      rethrow;
    }
  }

  /// Setting keys
  static const String showBeneficiaryImages = 'showBeneficiaryImages';
}
