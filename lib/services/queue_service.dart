import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'firebase_service.dart';

/// Service for managing Queues
class QueueService {
  static final CollectionReference _collection =
      FirebaseService.firestore.collection('queues');

  // Cache the stream controller to prevent multiple subscriptions
  static StreamController<List<Queue>>? _streamController;
  static StreamSubscription<QuerySnapshot>? _subscription;
  static String? _lastEmittedIds;

  /// Get all queues - returns cached stream to prevent multiple Firestore subscriptions
  static Stream<List<Queue>> getAllQueues() {
    // Return existing stream if already created
    if (_streamController != null && !_streamController!.isClosed) {
      return _streamController!.stream;
    }
    
    // Create new broadcast stream controller
    _streamController = StreamController<List<Queue>>.broadcast(
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

  /// Get queues for history view with limit (optimized for performance)
  static Stream<List<Queue>> getQueuesForHistory({int limit = 200}) {
    return FirebaseService.withRetry<QuerySnapshot>(
      () => _collection
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots(),
      maxRetries: 3,
      initialDelay: const Duration(milliseconds: 500),
    ).map((snapshot) {
      print('📦 QueueService: History - Received ${snapshot.docs.length} documents');
      return _processSnapshot(snapshot);
    });
  }

  static Future<void> _initializeStream() async {
    try {
      // First, try to get data from cache for instant display (limited to 200 for performance)
      try {
        final cacheSnapshot = await _collection
            .orderBy('createdAt', descending: true)
            .limit(200)
            .get(GetOptions(source: Source.cache));
        
        if (cacheSnapshot.docs.isNotEmpty) {
          print('📦 QueueService: Using cache - Received ${cacheSnapshot.docs.length} documents from Firestore cache');
          final cachedQueues = _processSnapshot(cacheSnapshot);
          
          // Set last emitted IDs
          final cachedIds = cachedQueues.map((q) => q.name + q.distributionArea).toList()..sort();
          _lastEmittedIds = cachedIds.join(',');
          
          // Emit cached data immediately for fast UI
          if (!_streamController!.isClosed) {
            _streamController!.add(cachedQueues);
          }
        }
      } catch (cacheError) {
        print('📦 QueueService: No cache available (${cacheError.toString()}), will fetch from server');
      }
      
      // Then fetch from server in the background for fresh data (limited to 200 for initial load)
      _collection
          .orderBy('createdAt', descending: true)
          .limit(200)
          .get(GetOptions(source: Source.server))
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              print('⏱️ QueueService: Server fetch timed out after 30 seconds');
              throw TimeoutException('Server fetch timed out');
            },
          )
          .then((serverSnapshot) {
            if (_streamController == null || _streamController!.isClosed) return;
            
            print('📦 QueueService: Server fetch - Received ${serverSnapshot.docs.length} documents from Firestore server');
            final serverQueues = _processSnapshot(serverSnapshot);
            
            // Only emit if the list has changed (check by IDs)
            final serverIds = serverQueues.map((q) => q.name + q.distributionArea).toList()..sort();
            final serverIdsStr = serverIds.join(',');
            
            if (serverIdsStr != _lastEmittedIds) {
              _lastEmittedIds = serverIdsStr;
              if (!_streamController!.isClosed) {
                _streamController!.add(serverQueues);
              }
            }
          })
          .catchError((error) {
            print('❌ Error fetching queues from server: $error');
            // If we don't have cached data, emit empty list to show something
            if (_lastEmittedIds == null && !_streamController!.isClosed) {
              _streamController!.add(<Queue>[]);
            }
          });
      
      // Now listen for real-time updates with retry logic (no limit for real-time updates)
      _subscription = FirebaseService.withRetry<QuerySnapshot>(
        () => _collection.orderBy('createdAt', descending: true).snapshots(),
        maxRetries: 5,
        initialDelay: const Duration(seconds: 1),
      ).listen(
        (snapshot) {
          if (_streamController == null || _streamController!.isClosed) return;
          
          print('📦 QueueService: Stream update - Received ${snapshot.docs.length} documents from Firestore');
          final queues = _processSnapshot(snapshot);
          
          // Only emit if the list has changed (check by IDs)
          final currentIds = queues.map((q) => q.name + q.distributionArea).toList()..sort();
          final currentIdsStr = currentIds.join(',');
          
          if (currentIdsStr != _lastEmittedIds) {
            _lastEmittedIds = currentIdsStr;
            if (!_streamController!.isClosed) {
              _streamController!.add(queues);
            }
          } else {
            print('⏭️ QueueService: Skipping duplicate emission');
          }
        },
        onError: (error) {
          print('❌ Error in queues stream: $error');
          if (_streamController != null && !_streamController!.isClosed) {
            _streamController!.addError(error);
          }
        },
      );
    } catch (e) {
      print('❌ Error initializing queues stream: $e');
      if (_streamController != null && !_streamController!.isClosed) {
        _streamController!.addError(e);
      }
    }
  }

  /// Process a Firestore snapshot into a list of Queue objects
  static List<Queue> _processSnapshot(QuerySnapshot snapshot) {
    final queues = snapshot.docs
        .map((doc) {
          try {
            return _documentToQueue(doc);
          } catch (e) {
            print('⚠️ Error converting queue document ${doc.id}: $e');
            return null;
          }
        })
        .whereType<Queue>()
        .toList();
    
    print('✅ QueueService: Converted ${queues.length} queues');
    return queues;
  }
  
  /// Get queue ID by name (helper method)
  static Future<String?> getQueueIdByName(String queueName) async {
    try {
      final query = await _collection
          .where('name', isEqualTo: queueName)
          .limit(1)
          .get();
      if (query.docs.isNotEmpty) {
        return query.docs.first.id;
      }
      return null;
    } catch (e) {
      print('Error getting queue ID by name: $e');
      return null;
    }
  }

  /// Get queues by distribution area
  static Stream<List<Queue>> getQueuesByArea(String distributionAreaId) {
    return FirebaseService.withRetry<QuerySnapshot>(
      () => _collection
          .where('distributionArea', isEqualTo: distributionAreaId)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      maxRetries: 5,
      initialDelay: const Duration(seconds: 1),
    ).map((snapshot) => snapshot.docs
        .map((doc) => _documentToQueue(doc))
        .toList());
  }

  /// Get queue by ID
  static Future<Queue?> getQueueById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return _documentToQueue(doc);
    }
    return null;
  }

  /// Create a new queue
  static Future<String> createQueue(Queue queue, String createdBy) async {
    final docRef = await _collection.add({
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
      'totalAvailableUnits': queue.totalAvailableUnits ?? queue.numberOfAvailableUnits, // Store initial total (same as numberOfAvailableUnits at creation)
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
    return docRef.id;
  }

  /// Update a queue
  static Future<void> updateQueue(String id, Queue queue) async {
    await _collection.doc(id).update({
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
      'totalAvailableUnits': queue.totalAvailableUnits, // Preserve existing totalAvailableUnits when updating (don't overwrite)
      'estimatedQueueSize': queue.estimatedQueueSize,
      'directServe': queue.directServe,
      'priority': queue.priority,
      'status': queue.status,
      'subtitle': queue.subtitle,
      'isStarted': queue.isStarted,
      'isCompleted': queue.isCompleted,
      'isSuspended': queue.isSuspended,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete a queue
  static Future<void> deleteQueue(String id) async {
    await _collection.doc(id).delete();
  }

  /// Convert Firestore document to Queue model
  static Queue _documentToQueue(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Queue(
      name: data['name'] ?? '',
      queueManager: data['queueManager'] ?? '',
      country: data['country'] ?? '',
      governorate: data['governorate'] ?? '',
      city: data['city'] ?? '',
      queuePointName: data['queuePointName'] ?? '',
      distributionArea: data['distributionArea'] ?? '',
      queueType: data['queueType'] ?? 'Single Day',
      fromDate: data['fromDate'] != null
          ? FirebaseService.timestampToDateTime(data['fromDate'] as Timestamp)
          : DateTime.now(),
      toDate: data['toDate'] != null
          ? FirebaseService.timestampToDateTime(data['toDate'] as Timestamp)
          : DateTime.now(),
      fromTime: data['fromTime'] != null
          ? FirebaseService.mapToTimeOfDay(data['fromTime'] as Map<String, dynamic>)
          : const TimeOfDay(hour: 0, minute: 0),
      toTime: data['toTime'] != null
          ? FirebaseService.mapToTimeOfDay(data['toTime'] as Map<String, dynamic>)
          : const TimeOfDay(hour: 23, minute: 59),
      unitName: data['customUnitName'] ?? data['unitName'] ?? 'Meals',
      numberOfAvailableUnits: data['numberOfAvailableUnits'] ?? 0,
      totalAvailableUnits: data['totalAvailableUnits'], // Initial total (null for old queues, will be calculated)
      estimatedQueueSize: data['estimatedQueueSize'] ?? 0,
      directServe: data['directServe'] ?? false,
      priority: List<String>.from(data['priority'] ?? []),
      status: data['status'] ?? 'active',
      subtitle: data['subtitle'],
      isStarted: data['isStarted'] ?? false,
      isCompleted: data['isCompleted'] ?? false,
      isSuspended: data['isSuspended'] ?? false,
    );
  }
}

