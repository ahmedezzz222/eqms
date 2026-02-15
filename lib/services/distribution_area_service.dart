import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'firebase_service.dart';

/// Service for managing Distribution Areas (Queue Points)
class DistributionAreaService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('distributionAreas');
  
  // Cache the stream controller to prevent multiple subscriptions
  static StreamController<List<DistributionArea>>? _streamController;
  static StreamSubscription<QuerySnapshot>? _subscription;
  static String? _lastEmittedIds;

  /// Get all distribution areas
  static Stream<List<DistributionArea>> getAllAreas() {
    // Return existing stream if already created
    if (_streamController != null && !_streamController!.isClosed) {
      return _streamController!.stream;
    }
    
    // Create new broadcast stream controller
    _streamController = StreamController<List<DistributionArea>>.broadcast(
      onListen: () {
        _initializeStream();
      },
      onCancel: () {
        _subscription?.cancel();
        _subscription = null;
        _lastEmittedIds = null;
      },
    );
    
    return _streamController!.stream;
  }
  
  static Future<void> _initializeStream() async {
    try {
      // Fetch initial data from server immediately
      final initialSnapshot = await _collection.get(GetOptions(source: Source.server));
      final initialAreas = _processSnapshot(initialSnapshot);
      
      // Set last emitted IDs
      final initialIds = initialAreas.map((a) => a.id).toList()..sort();
      _lastEmittedIds = initialIds.join(',');
      
      // Emit initial data
      if (!_streamController!.isClosed) {
        _streamController!.add(initialAreas);
      }
      
      // Now listen for real-time updates with retry logic
      _subscription = FirebaseService.withRetry<QuerySnapshot>(
        () => _collection.snapshots(),
        maxRetries: 5,
        initialDelay: const Duration(seconds: 1),
      ).listen(
        (snapshot) {
          if (_streamController == null || _streamController!.isClosed) return;
          final areas = _processSnapshot(snapshot);
          
          // Only emit if the list of IDs has changed
          final currentIds = areas.map((a) => a.id).toList()..sort();
          final currentIdsStr = currentIds.join(',');
          
          if (currentIdsStr != _lastEmittedIds) {
            _lastEmittedIds = currentIdsStr;
            if (!_streamController!.isClosed) {
              _streamController!.add(areas);
            }
          } else {
            print('⏭️ DistributionAreaService: Skipping duplicate emission');
          }
        },
        onError: (error) {
          print('❌ Error in distribution areas stream: $error');
          if (_streamController != null && !_streamController!.isClosed) {
            _streamController!.addError(error);
          }
        },
      );
    } catch (e) {
      print('❌ Error fetching initial distribution areas: $e');
      if (_streamController != null && !_streamController!.isClosed) {
        _streamController!.addError(e);
      }
    }
  }
  
  /// Process a Firestore snapshot into a list of DistributionArea objects
  static List<DistributionArea> _processSnapshot(QuerySnapshot snapshot) {
    final areas = snapshot.docs
        .map((doc) {
          try {
            return _documentToDistributionArea(doc);
          } catch (e) {
            print('⚠️ Error converting document ${doc.id}: $e');
            return null;
          }
        })
        .whereType<DistributionArea>()
        .toList();
    
    // Sort manually to avoid composite index requirement
    areas.sort((a, b) {
      final countryCompare = a.country.compareTo(b.country);
      if (countryCompare != 0) return countryCompare;
      final govCompare = a.governorate.compareTo(b.governorate);
      if (govCompare != 0) return govCompare;
      return a.city.compareTo(b.city);
    });
    return areas;
  }

  /// Get distribution area by ID
  static Future<DistributionArea?> getAreaById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToDistributionArea(doc);
    }
    return null;
  }

  /// Create a new distribution area
  static Future<String> createArea(DistributionArea area) async {
    final docRef = await _collection.add({
      'country': area.country,
      'governorate': area.governorate,
      'city': area.city,
      'areaName': area.areaName,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Update a distribution area
  static Future<void> updateArea(String id, DistributionArea area) async {
    await _collection.doc(id).update({
      'country': area.country,
      'governorate': area.governorate,
      'city': area.city,
      'areaName': area.areaName,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete a distribution area
  static Future<void> deleteArea(String id) async {
    await _collection.doc(id).delete();
  }

  /// Convert Firestore document to DistributionArea model
  static DistributionArea _documentToDistributionArea(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DistributionArea(
      id: doc.id,
      country: data['country'] ?? '',
      governorate: data['governorate'] ?? '',
      city: data['city'] ?? '',
      areaName: data['areaName'] ?? '',
    );
  }
}

