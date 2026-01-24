import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_ocr/flutter_native_ocr.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData, MethodChannel, Platform;
import 'google_lens_result_helper.dart';

/// Google Lens-like Live Text Detection Screen
/// Features:
/// - Real-time text detection from camera
/// - Selectable text blocks
/// - Copy text to clipboard
/// - Tap to select text
class LiveTextDetectionScreen extends StatefulWidget {
  const LiveTextDetectionScreen({super.key});

  @override
  State<LiveTextDetectionScreen> createState() => _LiveTextDetectionScreenState();
}

class _LiveTextDetectionScreenState extends State<LiveTextDetectionScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isProcessing = false;
  FlutterNativeOcr? _ocr;
  String? _recognizedText;
  String? _selectedText;
  Timer? _processingTimer;
  static const MethodChannel _googleLensChannel = MethodChannel('com.et3amapp.eqmsapp/google_lens');
  String? _googleLensResult;
  bool _waitingForGoogleLens = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
    // Start monitoring clipboard for Google Lens results
    GoogleLensResultHelper.startMonitoring(_onGoogleLensTextDetected);
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    GoogleLensResultHelper.stopMonitoring();
    _processingTimer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    // When app resumes, check clipboard for Google Lens results
    if (state == AppLifecycleState.resumed && _waitingForGoogleLens) {
      _checkForGoogleLensResult();
    }
  }
  
  /// Callback when text is detected from clipboard (Google Lens)
  void _onGoogleLensTextDetected(String text) {
    if (_waitingForGoogleLens && mounted) {
      setState(() {
        _googleLensResult = text;
        _waitingForGoogleLens = false;
      });
      _showGoogleLensResultDialog(text);
    }
  }
  
  /// Check clipboard for Google Lens result when app resumes
  Future<void> _checkForGoogleLensResult() async {
    if (!_waitingForGoogleLens) return;
    
    // Wait a bit for clipboard to be updated
    await Future.delayed(const Duration(milliseconds: 500));
    
    final clipboardText = await GoogleLensResultHelper.getClipboardText();
    if (clipboardText != null && clipboardText.isNotEmpty && clipboardText.length > 3) {
      if (mounted) {
        setState(() {
          _googleLensResult = clipboardText;
          _waitingForGoogleLens = false;
        });
        _showGoogleLensResultDialog(clipboardText);
      }
    }
  }
  
  /// Show dialog with Google Lens detected text
  void _showGoogleLensResultDialog(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.lens, color: Color(0xFF81CF01)),
            SizedBox(width: 8),
            Text('Google Lens Result'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Detected text from Google Lens:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SelectableText(
                text,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Close the dialog first
              Navigator.of(context).pop();
              // Set as selected text
              setState(() {
                _selectedText = text;
              });
              // Copy to clipboard
              Clipboard.setData(ClipboardData(text: text));
              // Return the text to the previous screen (beneficiary registration)
              Navigator.of(context).pop(text);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Text copied and set as selected'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF81CF01),
              foregroundColor: Colors.white,
            ),
            child: const Text('Use This Text'),
          ),
        ],
      ),
    );
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

      // Initialize OCR
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
    // Process frames every 1000ms (1 second) to avoid overwhelming the device
    // Reduced frequency for better performance and accuracy
    _processingTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!_isProcessing && _cameraController != null && _cameraController!.value.isInitialized) {
        _processCameraFrame();
      }
    });
  }

  Future<void> _processCameraFrame() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized || _ocr == null) {
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final image = await _cameraController!.takePicture();
      
      // Use flutter_native_ocr to recognize text
      final recognizedText = await _ocr!.recognizeText(image.path);

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
          // Google Lens button
          if (Platform.isAndroid)
            IconButton(
              icon: const Icon(Icons.lens),
              onPressed: _launchGoogleLensCamera,
              tooltip: 'Open Google Lens',
            ),
          if (_selectedText != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _selectedText!));
                // Return the selected text to the previous screen
                Navigator.of(context).pop(_selectedText);
              },
              tooltip: 'Use selected text',
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
                    'Tap on detected text to select and copy\nOr use Google Lens for better detection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                // Google Lens button
                if (Platform.isAndroid)
                  ElevatedButton.icon(
                    onPressed: _launchGoogleLensWithImage,
                    icon: const Icon(Icons.lens),
                    label: const Text('Use Google Lens'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF81CF01),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
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

  /// Launch Google Lens camera directly
  Future<void> _launchGoogleLensCamera() async {
    try {
      if (Platform.isAndroid) {
        // Set flag to monitor for results
        setState(() {
          _waitingForGoogleLens = true;
        });
        
        final result = await _googleLensChannel.invokeMethod('launchGoogleLensCamera');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Google Lens opened. Copy the detected text and return to app.'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: 'Got it',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _waitingForGoogleLens = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Launch Google Lens with current camera frame
  Future<void> _launchGoogleLensWithImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera not ready'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Set flag to monitor for results
      setState(() {
        _waitingForGoogleLens = true;
      });
      
      // Show loading
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Capturing image for Google Lens...'),
            duration: Duration(seconds: 1),
          ),
        );
      }

      // Take a picture
      final image = await _cameraController!.takePicture();
      
      if (Platform.isAndroid) {
        final result = await _googleLensChannel.invokeMethod(
          'launchGoogleLens',
          {'imagePath': image.path},
        );
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Google Lens opened. Copy the detected text and return to app.'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
              action: SnackBarAction(
                label: 'Got it',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _waitingForGoogleLens = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

// Note: TextOverlayPainter removed - flutter_native_ocr doesn't provide bounding boxes
// Text is now displayed in a simple overlay container instead

