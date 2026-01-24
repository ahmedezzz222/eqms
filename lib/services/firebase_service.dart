import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Main Firebase service class
class FirebaseService {
  static FirebaseFirestore? _firestore;
  static FirebaseAuth? _auth;
  static FirebaseStorage? _storage;
  static bool _isInitialized = false;

  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception('Firebase not initialized. Please configure Firebase first.');
    }
    return _firestore!;
  }

  static FirebaseAuth get auth {
    if (_auth == null) {
      throw Exception('Firebase not initialized. Please configure Firebase first.');
    }
    return _auth!;
  }

  static FirebaseStorage get storage {
    if (_storage == null) {
      throw Exception('Firebase not initialized. Please configure Firebase first.');
    }
    return _storage!;
  }

  static bool get isInitialized => _isInitialized;

  /// Initialize Firebase (call this in main.dart)
  /// If you have a named database, specify it here (e.g., 'et3amdb' or 'et3ambd')
  static Future<void> initialize({String? databaseId}) async {
    try {
      // Use named database if provided, otherwise use default
      if (databaseId != null && databaseId.isNotEmpty) {
        _firestore = FirebaseFirestore.instanceFor(
          app: Firebase.app(),
          databaseId: databaseId,
        );
        print('✅ Firebase initialized with named database: $databaseId');
      } else {
        _firestore = FirebaseFirestore.instance;
        print('✅ Firebase initialized with default database');
      }
      _auth = FirebaseAuth.instance;
      _storage = FirebaseStorage.instance;
      _isInitialized = true;
      print('✅ Firebase initialized successfully');
    } catch (e) {
      print('⚠️ Firebase initialization failed: $e');
      print('⚠️ App will continue without Firebase. Please configure Firebase to use cloud features.');
      _isInitialized = false;
    }
  }

  /// Helper method to convert TimeOfDay to Map
  static Map<String, int> timeOfDayToMap(TimeOfDay time) {
    return {
      'hour': time.hour,
      'minute': time.minute,
    };
  }

  /// Helper method to convert Map to TimeOfDay
  static TimeOfDay mapToTimeOfDay(Map<String, dynamic> map) {
    return TimeOfDay(
      hour: map['hour'] as int,
      minute: map['minute'] as int,
    );
  }

  /// Helper method to convert DateTime to Timestamp
  static Timestamp dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromDate(dateTime);
  }

  /// Helper method to convert Timestamp to DateTime
  static DateTime timestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  /// Wraps a Firestore stream with retry logic using exponential backoff
  /// This handles transient errors like 'cloud_firestore/unavailable'
  static Stream<T> withRetry<T>(Stream<T> Function() streamFactory, {
    int maxRetries = 5,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
  }) {
    StreamController<T>? controller;
    StreamSubscription<T>? subscription;
    int retryCount = 0;
    Timer? retryTimer;

    void startStream() {
      try {
        subscription?.cancel();
        subscription = streamFactory().listen(
          (data) {
            retryCount = 0; // Reset retry count on success
            controller?.add(data);
          },
          onError: (error) {
            // Check if it's a retryable error
            final errorString = error.toString().toLowerCase();
            final isRetryable = errorString.contains('unavailable') ||
                errorString.contains('deadline exceeded') ||
                errorString.contains('internal') ||
                errorString.contains('transient');

            if (isRetryable && retryCount < maxRetries) {
              retryCount++;
              final delay = Duration(
                milliseconds: (initialDelay.inMilliseconds * 
                    (backoffMultiplier * retryCount)).round(),
              );
              
              print('⚠️ Firestore stream error (retryable): $error');
              print('🔄 Retrying in ${delay.inSeconds} seconds (attempt $retryCount/$maxRetries)...');
              
              retryTimer?.cancel();
              retryTimer = Timer(delay, () {
                startStream();
              });
            } else {
              // Non-retryable error or max retries reached
              print('❌ Firestore stream error: $error');
              if (retryCount >= maxRetries) {
                print('❌ Max retries ($maxRetries) reached. Giving up.');
              }
              controller?.addError(error);
            }
          },
          onDone: () {
            controller?.close();
          },
          cancelOnError: false,
        );
      } catch (e) {
        controller?.addError(e);
      }
    }

    controller = StreamController<T>(
      onListen: startStream,
      onCancel: () {
        retryTimer?.cancel();
        subscription?.cancel();
        subscription = null;
      },
    );

    return controller.stream;
  }
}

