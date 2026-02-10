import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_ocr/flutter_native_ocr.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

/// ML Kit OCR Live Text Detection Screen
/// Features:
/// - Real-time text detection from camera using Google ML Kit
/// - Automatic Arabic text recognition
/// - Selectable text blocks
/// - Auto-return on detection
class LiveTextDetectionScreen extends StatefulWidget {
  final bool autoReturnOnDetect;
  
  const LiveTextDetectionScreen({
    super.key,
    this.autoReturnOnDetect = false,
  });

  @override
  State<LiveTextDetectionScreen> createState() => _LiveTextDetectionScreenState();
}

class _LiveTextDetectionScreenState extends State<LiveTextDetectionScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isProcessing = false;
  FlutterNativeOcr? _ocr; // Fallback OCR
  TextRecognizer? _mlKitTextRecognizer; // Google ML Kit Text Recognizer with Arabic support
  String? _recognizedText;
  String? _selectedText;
  Timer? _processingTimer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }
  
  @override
  void dispose() {
    // Stop processing first to prevent new frames from being processed
    _processingTimer?.cancel();
    _isProcessing = false;
    
    // Dispose camera controller properly
    _cameraController?.dispose();
    
    // Close ML Kit recognizer
    _mlKitTextRecognizer?.close();
    
    // Dispose fallback OCR
    _ocr = null;
    
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      // Request camera permission
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Camera permission is required for live text detection'),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.of(context).pop();
        }
        return;
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No cameras available'),
              backgroundColor: Colors.red,
            ),
          );
          Navigator.of(context).pop();
        }
        return;
      }

      // Initialize camera controller (use back camera)
      final backCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();

      // Initialize Google ML Kit Text Recognizer
      // Note: ML Kit automatically detects Arabic and Latin scripts
      // For better Arabic support, we use the default recognizer which supports multiple scripts
      _mlKitTextRecognizer = TextRecognizer();
      
      // Also initialize fallback OCR
      _ocr = FlutterNativeOcr();

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        _startTextDetection();
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error initializing camera: $e'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  void _startTextDetection() {
    // Process frames every 1500ms (1.5 seconds) to allow more text to accumulate
    // This gives better accuracy for full ID card detection
    _processingTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (!_isProcessing && _cameraController != null && _cameraController!.value.isInitialized) {
        _processCameraFrame();
      }
    });
  }

  Future<void> _processCameraFrame() async {
    if (!mounted || _cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final image = await _cameraController!.takePicture();
      
      // Check if still mounted after taking picture
      if (!mounted) {
        // Clean up the image file if we're disposing
        try {
          final file = File(image.path);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          print('Error cleaning up image file: $e');
        }
        return;
      }
      
      String recognizedText = '';
      
      // Try Google ML Kit Text Recognition first (better Arabic support)
      // ML Kit supports Arabic (ar) language as per Google Cloud Vision API documentation
      if (_mlKitTextRecognizer != null) {
        try {
          final inputImage = InputImage.fromFilePath(image.path);
          final recognizedTextResult = await _mlKitTextRecognizer!.processImage(inputImage);
          
          // Combine all detected text blocks with proper line breaks
          final textBlocks = <String>[];
          for (final block in recognizedTextResult.blocks) {
            final blockText = <String>[];
            for (final line in block.lines) {
              blockText.add(line.text);
            }
            textBlocks.add(blockText.join(' '));
          }
          recognizedText = textBlocks.join('\n');
          
          print('📝 ML Kit detected ${recognizedTextResult.blocks.length} text blocks');
          print('📝 ML Kit text (length: ${recognizedText.length}): ${recognizedText.substring(0, recognizedText.length > 200 ? 200 : recognizedText.length)}');
        } catch (e) {
          print('⚠️ ML Kit OCR error: $e, falling back to native OCR');
          // Fallback to native OCR if ML Kit fails
          if (_ocr != null) {
            recognizedText = await _ocr!.recognizeText(image.path);
          }
        }
      } else if (_ocr != null) {
        // Fallback to native OCR if ML Kit not initialized
        recognizedText = await _ocr!.recognizeText(image.path);
      }

      // Delete temporary image file
      final file = File(image.path);
      if (await file.exists()) {
        await file.delete();
      }

      if (mounted) {
        setState(() {
          _recognizedText = recognizedText;
          _isProcessing = false;
        });
        
        print('📝 OCR detected text (length: ${recognizedText.length}): ${recognizedText.substring(0, recognizedText.length > 200 ? 200 : recognizedText.length)}');
        
        // If auto-return is enabled and text looks like ID data, return automatically
        if (widget.autoReturnOnDetect && recognizedText.isNotEmpty) {
          // Check if text contains ID-like data (very lenient criteria)
          final hasIdNumber = RegExp(r'\d{10,14}').hasMatch(recognizedText);
          final hasArabic = RegExp(r'[أ-ي]').hasMatch(recognizedText);
          final hasEnglish = RegExp(r'[A-Za-z]{2,}').hasMatch(recognizedText);
          final hasNumbers = RegExp(r'\d{6,}').hasMatch(recognizedText); // Reduced to 6 digits
          
          // Check if we have both ID number and name (better detection)
          final hasBothIdAndName = hasIdNumber && (hasArabic || hasEnglish);
          
          print('📝 Auto-return check: hasIdNumber=$hasIdNumber, hasArabic=$hasArabic, hasEnglish=$hasEnglish, hasNumbers=$hasNumbers, hasBothIdAndName=$hasBothIdAndName, length=${recognizedText.length}');
          
          // Improved criteria: prefer text with both ID number and name, or at least ID number with sufficient length
          // Wait for better quality detection (at least 30 characters suggests more complete text)
          final isHighQuality = hasBothIdAndName && recognizedText.length > 30;
          final isMediumQuality = hasIdNumber && recognizedText.length > 20;
          final isLowQuality = (hasNumbers && (hasArabic || hasEnglish)) || recognizedText.length > 15;
          
          if (isHighQuality) {
            print('✅ Auto-returning OCR text (high quality: ID + name detected)');
            // Return immediately for high quality detection
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                print('📤 Returning OCR text to form: ${recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length)}...');
                Navigator.of(context).pop(recognizedText);
              }
            });
          } else if (isMediumQuality) {
            print('✅ Auto-returning OCR text (medium quality: ID detected)');
            // Wait a bit longer for medium quality to see if more text appears
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (mounted && _recognizedText == recognizedText) {
                print('📤 Returning OCR text to form: ${recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length)}...');
                Navigator.of(context).pop(recognizedText);
              }
            });
          } else if (isLowQuality) {
            print('⚠️ OCR text detected but quality is low - waiting for better detection');
            // Don't auto-return for low quality, let user manually select
          } else {
            print('⚠️ OCR text does not match ID criteria - user can manually select');
          }
        }
      }
    } catch (e) {
      print('Error processing frame: $e');
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _onTextTap(String text) {
    setState(() {
      _selectedText = text;
    });

    // Show dialog with selected text
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detected Text'),
        content: SingleChildScrollView(
          child: SelectableText(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: text));
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Text copied to clipboard'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _cameraController == null || !_cameraController!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Live Text Detection'),
          backgroundColor: const Color(0xFF81CF01),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // Check clipboard for copied text when user presses back button
        try {
          final clipboardText = await Clipboard.getData(Clipboard.kTextPlain);
          if (clipboardText?.text != null && 
              clipboardText!.text!.isNotEmpty && 
              clipboardText.text!.length > 3) {
            // Return the clipboard text if it looks like ID card data
            final hasNumbers = RegExp(r'\d{8,}').hasMatch(clipboardText.text!);
            final hasArabic = RegExp(r'[أ-ي]').hasMatch(clipboardText.text!);
            if (hasNumbers || hasArabic) {
              if (mounted) {
                Navigator.of(context).pop(clipboardText.text);
              }
              return;
            }
          }
        } catch (e) {
          print('Error checking clipboard: $e');
        }
        // Allow default back navigation
        if (mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Live Text Detection'),
          backgroundColor: const Color(0xFF81CF01),
          foregroundColor: Colors.white,
          actions: [
          if (_selectedText != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _selectedText!));
                print('📤 Returning manually selected text: ${_selectedText!.substring(0, _selectedText!.length > 100 ? 100 : _selectedText!.length)}...');
                Navigator.of(context).pop(_selectedText);
              },
              tooltip: 'Use selected text',
            ),
          // Add button to return current recognized text even if not manually selected
          if (_recognizedText != null && _recognizedText!.isNotEmpty && widget.autoReturnOnDetect)
            IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: () {
                print('📤 Returning current OCR text: ${_recognizedText!.substring(0, _recognizedText!.length > 100 ? 100 : _recognizedText!.length)}...');
                Navigator.of(context).pop(_recognizedText);
              },
              tooltip: 'Use detected text',
              color: Colors.green,
            ),
        ],
      ),
      body: Stack(
        children: [
          // Camera preview
          Positioned.fill(
            child: CameraPreview(_cameraController!),
          ),
          // Text display overlay (flutter_native_ocr doesn't provide bounding boxes)
          if (_recognizedText != null && _recognizedText!.isNotEmpty)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => _onTextTap(_recognizedText!),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _selectedText == _recognizedText 
                          ? Colors.green 
                          : Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: SelectableText(
                    _recognizedText!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          // Instructions overlay
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Tap on detected text to select and copy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  // Note: flutter_native_ocr doesn't provide bounding boxes, so tap handling is simplified
  // Users can tap on the text overlay to select it
}

// Note: TextOverlayPainter removed - flutter_native_ocr doesn't provide bounding boxes
// Text is now displayed in a simple overlay container instead

