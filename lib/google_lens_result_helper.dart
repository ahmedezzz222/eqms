import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, MethodChannel, Platform;

/// Helper class to capture Google Lens results
/// Monitors clipboard and provides callbacks when text is detected
class GoogleLensResultHelper {
  static const MethodChannel _channel = MethodChannel('com.et3amapp.eqmsapp/google_lens');
  
  static Timer? _clipboardMonitor;
  static String? _lastClipboardText;
  static Function(String)? _onTextDetected;
  static bool _isMonitoring = false;
  
  /// Start monitoring clipboard for Google Lens results
  /// This checks clipboard every 100ms when app is active
  static Future<void> startMonitoring(Function(String) onTextDetected) async {
    // Stop any existing monitoring first
    stopMonitoring();
    
    // Clear clipboard and reset tracking to avoid detecting old data
    await clearClipboard();
    _lastClipboardText = null;
    
    _onTextDetected = onTextDetected;
    _isMonitoring = true;
    
    // Small delay to ensure clipboard is cleared before starting monitoring
    await Future.delayed(const Duration(milliseconds: 200));
    
    // Monitor clipboard very frequently for fastest detection (every 100ms)
    _clipboardMonitor = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _checkClipboard();
    });
  }
  
  /// Stop monitoring clipboard
  static void stopMonitoring() {
    _clipboardMonitor?.cancel();
    _clipboardMonitor = null;
    _isMonitoring = false;
    _onTextDetected = null;
    _lastClipboardText = null;
  }
  
  /// Check clipboard for new text
  static Future<void> _checkClipboard() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final currentText = clipboardData?.text;
      
      // If clipboard has new text and it's different from last known text
      if (currentText != null && 
          currentText.isNotEmpty && 
          currentText != _lastClipboardText) {
        _lastClipboardText = currentText;
        
        // Only trigger if text seems meaningful (more than 3 characters)
        // For ID scanning, we want to detect even shorter text if it contains numbers
        final hasNumbers = RegExp(r'\d{8,}').hasMatch(currentText);
        final hasText = currentText.length > 3;
        
        if ((hasText || hasNumbers) && _onTextDetected != null) {
          _onTextDetected!(currentText);
        }
      }
    } catch (e) {
      print('Error checking clipboard: $e');
    }
  }
  
  /// Get current clipboard text
  static Future<String?> getClipboardText() async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      return clipboardData?.text;
    } catch (e) {
      print('Error getting clipboard text: $e');
      return null;
    }
  }
  
  /// Clear clipboard
  static Future<void> clearClipboard() async {
    try {
      await Clipboard.setData(const ClipboardData(text: ''));
      _lastClipboardText = '';
    } catch (e) {
      print('Error clearing clipboard: $e');
    }
  }
}

