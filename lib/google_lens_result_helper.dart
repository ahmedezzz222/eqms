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
  /// This checks clipboard every 500ms when app is active
  static void startMonitoring(Function(String) onTextDetected) {
    if (_isMonitoring) return;
    
    _onTextDetected = onTextDetected;
    _isMonitoring = true;
    
    // Get initial clipboard content
    _checkClipboard();
    
    // Monitor clipboard periodically
    _clipboardMonitor = Timer.periodic(const Duration(milliseconds: 500), (timer) {
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
        if (currentText.length > 3 && _onTextDetected != null) {
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

