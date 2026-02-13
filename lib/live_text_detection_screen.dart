import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_native_ocr/flutter_native_ocr.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:image/image.dart' as img;

/// ML Kit OCR Live Text Detection Screen
/// Features:
/// - Real-time text detection from camera using Google ML Kit
/// - Automatic Arabic text recognition
/// - Selectable text blocks
/// - Auto-return on detection
/// - Optional manual-only mode: no automatic capture, user taps Capture to scan
class LiveTextDetectionScreen extends StatefulWidget {
  final bool autoReturnOnDetect;
  /// When true, no automatic periodic capture; user must tap Capture to scan.
  final bool manualCaptureOnly;
  
  const LiveTextDetectionScreen({
    super.key,
    this.autoReturnOnDetect = false,
    this.manualCaptureOnly = false,
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
  bool _isOcrProcessing = false; // Track if OCR is actively processing
  List<TextBlock>? _detectedTextBlocks; // Store detected text blocks with bounding boxes
  Timer? _clipboardMonitor; // Monitor clipboard for copied text

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _startClipboardMonitoring();
  }
  
  /// Start monitoring clipboard for copied text
  void _startClipboardMonitoring() {
    _clipboardMonitor = Timer.periodic(const Duration(milliseconds: 300), (timer) async {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      try {
        final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
        final clipboardText = clipboardData?.text;
        
        // If clipboard has meaningful text (ID-like data), return it
        if (clipboardText != null && clipboardText.isNotEmpty && clipboardText.length > 5) {
          final hasNumbers = RegExp(r'\d{8,}').hasMatch(clipboardText);
          final hasArabic = RegExp(r'[أ-ي]').hasMatch(clipboardText);
          
          if (hasNumbers || hasArabic) {
            print('📋 Clipboard text detected: ${clipboardText.substring(0, clipboardText.length > 100 ? 100 : clipboardText.length)}...');
            timer.cancel();
            if (mounted) {
              Navigator.of(context).pop(clipboardText);
            }
          }
        }
      } catch (e) {
        print('Error checking clipboard: $e');
      }
    });
  }
  
  @override
  void dispose() {
    print('🛑 Disposing LiveTextDetectionScreen...');
    
    // Stop processing timer first to prevent new frames from being processed
    _processingTimer?.cancel();
    _processingTimer = null;
    
    // Stop clipboard monitoring
    _clipboardMonitor?.cancel();
    _clipboardMonitor = null;
    
    // Set processing flag to true to block any new processing attempts
    // This prevents new frames from being queued during disposal
    _isProcessing = true;
    _isOcrProcessing = false;
    
    // Wait a bit for any ongoing OCR operations to complete
    // This prevents disposal while ML Kit is still processing
    Future.delayed(const Duration(milliseconds: 500), () {
      // Close ML Kit recognizer first (before camera)
      _mlKitTextRecognizer?.close();
      _mlKitTextRecognizer = null;
      
      // Dispose fallback OCR
      _ocr = null;
      
      // Dispose camera controller last
      // The camera controller will handle cleanup of any queued frames
      _cameraController?.dispose();
      _cameraController = null;
    });
    
    print('✅ LiveTextDetectionScreen disposal initiated');
    
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
        ResolutionPreset.veryHigh, // Use very high resolution for better OCR accuracy
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
        if (!widget.manualCaptureOnly) {
          _startTextDetection();
        }
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
      if (!mounted || _cameraController == null || !_cameraController!.value.isInitialized) {
        timer.cancel();
        _processingTimer = null;
        return;
      }
      if (!_isProcessing) {
        _processCameraFrame();
      }
    });
  }

  Future<void> _processCameraFrame() async {
    // Check multiple conditions before processing
    if (!mounted) {
      print('⚠️ Widget not mounted, skipping frame processing');
      return;
    }
    
    if (_cameraController == null) {
      print('⚠️ Camera controller is null, skipping frame processing');
      return;
    }
    
    if (!_cameraController!.value.isInitialized) {
      print('⚠️ Camera not initialized, skipping frame processing');
      return;
    }
    
    // Check if processing timer was cancelled (indicates disposal in progress)
    if (_processingTimer == null) {
      print('⚠️ Processing timer cancelled, skipping frame processing');
      return;
    }
    
    // Double-check mounted state before setState
    if (!mounted) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Wait longer for camera to stabilize and focus before capturing
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Ensure camera is focused before capturing
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        try {
          await _cameraController!.setFocusMode(FocusMode.auto);
          await Future.delayed(const Duration(milliseconds: 500)); // Wait for focus
          print('✅ Camera focus set to auto');
        } catch (e) {
          print('⚠️ Could not set focus mode: $e');
        }
      }
      
      // Double-check camera is still valid before taking picture
      if (_cameraController == null || !_cameraController!.value.isInitialized || !mounted) {
        print('⚠️ Camera invalid or widget disposed, skipping picture capture');
        return;
      }
      
      final image = await _cameraController!.takePicture();
      
      // Check if still mounted and camera still valid after taking picture
      if (!mounted || _cameraController == null || !_cameraController!.value.isInitialized) {
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
      
      // Check if image file exists and has content
      final imageFile = File(image.path);
      if (!await imageFile.exists()) {
        print('❌ Image file does not exist: ${image.path}');
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
        return;
      }
      
      final fileSize = await imageFile.length();
      if (fileSize == 0) {
        print('❌ Image file is empty');
        if (mounted) {
          setState(() {
            _isProcessing = false;
          });
        }
        return;
      }
      
      print('📸 Image captured: ${image.path}, size: ${fileSize} bytes');
      
      // Preprocess image for better OCR results
      String? processedImagePath;
      try {
        print('🔄 Preprocessing image for better OCR detection...');
        processedImagePath = await _preprocessImageForOCR(image.path);
        if (processedImagePath != null) {
          print('✅ Image preprocessed: $processedImagePath');
        } else {
          print('⚠️ Image preprocessing failed, using original image');
          processedImagePath = image.path;
        }
      } catch (e) {
        print('⚠️ Error preprocessing image: $e, using original');
        processedImagePath = image.path;
      }
      
      String recognizedText = '';
      
      // Try Google ML Kit Text Recognition first (better Arabic support)
      // ML Kit supports Arabic (ar) language as per Google Cloud Vision API documentation
      if (_mlKitTextRecognizer != null) {
        try {
          // Mark OCR as processing to prevent disposal
          _isOcrProcessing = true;
          
          // Use preprocessed image if available, otherwise use original
          final imagePathToUse = processedImagePath ?? image.path;
          
          // Try multiple methods to create InputImage
          InputImage inputImage;
          try {
            // Method 1: Try with file path (most common)
            inputImage = InputImage.fromFilePath(imagePathToUse);
            print('✅ Created InputImage from file path: $imagePathToUse');
          } catch (e) {
            print('⚠️ Failed to create InputImage from path, trying from file: $e');
            // Method 2: Try with File object
            final fileToUse = File(imagePathToUse);
            inputImage = InputImage.fromFile(fileToUse);
            print('✅ Created InputImage from File object');
          }
          
          print('🔍 Processing image with ML Kit...');
          print('⏱️ Starting ML Kit OCR at: ${DateTime.now()}');
          
          // Process with timeout (30 seconds max)
          final recognizedTextResult = await _mlKitTextRecognizer!
              .processImage(inputImage)
              .timeout(
                const Duration(seconds: 30),
                onTimeout: () {
                  print('⏱️ ML Kit OCR timeout after 30 seconds');
                  _isOcrProcessing = false;
                  throw TimeoutException('ML Kit OCR processing timed out');
                },
              );
          
          print('⏱️ ML Kit OCR completed at: ${DateTime.now()}');
          print('📊 ML Kit result: ${recognizedTextResult.blocks.length} blocks detected');
          
          // Store text blocks for overlay display
          _detectedTextBlocks = recognizedTextResult.blocks;
          
          // Combine all detected text blocks with proper line breaks
          final textBlocks = <String>[];
          int totalLines = 0;
          for (final block in recognizedTextResult.blocks) {
            final blockText = <String>[];
            for (final line in block.lines) {
              blockText.add(line.text);
              totalLines++;
            }
            textBlocks.add(blockText.join(' '));
          }
          recognizedText = textBlocks.join('\n');
          
          print('📝 ML Kit detected ${recognizedTextResult.blocks.length} text blocks, $totalLines lines');
          print('📝 ML Kit text (length: ${recognizedText.length}): ${recognizedText.length > 0 ? recognizedText.substring(0, recognizedText.length > 200 ? 200 : recognizedText.length) : "(empty)"}');
          
          // Log first few blocks for debugging
          if (recognizedTextResult.blocks.isNotEmpty) {
            print('📋 First 3 blocks preview:');
            for (int i = 0; i < recognizedTextResult.blocks.length && i < 3; i++) {
              final block = recognizedTextResult.blocks[i];
              final blockText = block.lines.map((line) => line.text).join(' ');
              print('   Block $i: ${blockText.length > 50 ? blockText.substring(0, 50) + "..." : blockText}');
            }
          }
          
          // Mark OCR as complete
          _isOcrProcessing = false;
          
          // If ML Kit returns empty or very short text, try original image if we used preprocessed
          if (recognizedText.trim().isEmpty || recognizedText.trim().length < 5) {
            if (processedImagePath != null && processedImagePath != image.path) {
              print('⚠️ ML Kit with preprocessed image returned empty, trying original image...');
              _isOcrProcessing = true; // Mark as processing again
              try {
                final originalInputImage = InputImage.fromFilePath(image.path);
                final originalResult = await _mlKitTextRecognizer!
                    .processImage(originalInputImage)
                    .timeout(
                      const Duration(seconds: 30),
                      onTimeout: () {
                        _isOcrProcessing = false;
                        throw TimeoutException('ML Kit OCR processing timed out');
                      },
                    );
                
                final originalTextBlocks = <String>[];
                for (final block in originalResult.blocks) {
                  final blockText = <String>[];
                  for (final line in block.lines) {
                    blockText.add(line.text);
                  }
                  originalTextBlocks.add(blockText.join(' '));
                }
                final originalText = originalTextBlocks.join('\n');
                
                print('📝 ML Kit (original image) detected ${originalResult.blocks.length} blocks, text length: ${originalText.length}');
                if (originalText.trim().isNotEmpty && originalText.trim().length > recognizedText.trim().length) {
                  recognizedText = originalText;
                  print('✅ Using original image result (better than preprocessed)');
                }
                _isOcrProcessing = false;
              } catch (e) {
                _isOcrProcessing = false;
                print('⚠️ Error trying original image with ML Kit: $e');
              }
            }
            
            // If still empty, try fallback OCR
            if (recognizedText.trim().isEmpty || recognizedText.trim().length < 5) {
              print('⚠️ ML Kit returned empty or very short text, trying fallback OCR...');
              if (_ocr != null) {
                try {
                  // Try preprocessed image first
                  final ocrImagePath = processedImagePath ?? image.path;
                  print('🔍 Trying fallback OCR with preprocessed image: $ocrImagePath');
                  var fallbackText = await _ocr!.recognizeText(ocrImagePath);
                  print('📝 Fallback OCR (preprocessed) raw result length: ${fallbackText.length}');
                  
                  // If preprocessed image fails, try original image
                  if (fallbackText.trim().isEmpty && processedImagePath != null && processedImagePath != image.path) {
                    print('⚠️ Preprocessed image failed, trying original image...');
                    fallbackText = await _ocr!.recognizeText(image.path);
                    print('📝 Fallback OCR (original) raw result length: ${fallbackText.length}');
                  }
                  
                  if (fallbackText.trim().isNotEmpty) {
                    recognizedText = fallbackText;
                    print('✅ Fallback OCR found text (length: ${recognizedText.length}): ${recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length)}');
                  } else {
                    print('⚠️ Both preprocessed and original images returned empty text');
                    // Try reading image bytes for debugging
                    final imageBytes = await imageFile.readAsBytes();
                    print('📦 Image bytes read: ${imageBytes.length} bytes - image may be corrupted or unreadable');
                  }
                } catch (e, stackTrace) {
                  print('⚠️ Fallback OCR error: $e');
                  print('Stack trace: $stackTrace');
                }
              }
            }
          }
        } catch (e, stackTrace) {
          _isOcrProcessing = false;
          print('❌ ML Kit OCR error: $e');
          print('Stack trace: $stackTrace');
          print('⚠️ Falling back to native OCR...');
          // Fallback to native OCR if ML Kit fails
          if (_ocr != null) {
            try {
              final ocrImagePath = processedImagePath ?? image.path;
              print('🔍 Trying fallback OCR with path: $ocrImagePath');
              recognizedText = await _ocr!.recognizeText(ocrImagePath);
              print('✅ Fallback OCR result (length: ${recognizedText.length}): ${recognizedText.length > 0 ? recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length) : "(empty)"}');
            } catch (e2, stackTrace2) {
              print('❌ Fallback OCR also failed: $e2');
              print('Stack trace: $stackTrace2');
            }
          } else {
            print('❌ No fallback OCR available');
          }
        }
      } else if (_ocr != null) {
        // Fallback to native OCR if ML Kit not initialized
        try {
          final ocrImagePath = processedImagePath ?? image.path;
          recognizedText = await _ocr!.recognizeText(ocrImagePath);
          print('✅ Native OCR result (length: ${recognizedText.length})');
        } catch (e) {
          print('❌ Native OCR error: $e');
        }
      }

      // Delete temporary image files (original and processed)
      try {
      final file = File(image.path);
      if (await file.exists()) {
        await file.delete();
        }
        if (processedImagePath != null && processedImagePath != image.path) {
          final processedFile = File(processedImagePath);
          if (await processedFile.exists()) {
            await processedFile.delete();
          }
        }
      } catch (e) {
        print('⚠️ Error cleaning up image files: $e');
      }

      if (mounted) {
        setState(() {
          _recognizedText = recognizedText;
          _isProcessing = false;
          // Clear text blocks if no text detected
          if (recognizedText.isEmpty) {
            _detectedTextBlocks = null;
          }
        });
        
        print('📝 OCR detected text (length: ${recognizedText.length}): ${recognizedText.isNotEmpty ? recognizedText.substring(0, recognizedText.length > 200 ? 200 : recognizedText.length) : "(empty)"}');
        
        // Show feedback if no text detected
        if (recognizedText.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No text detected. Please ensure:\n• Good lighting\n• ID card is in focus\n• Card fills the frame'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 4),
            ),
          );
        }
        
        // If auto-return is enabled and text looks like ID data, return automatically
        if (widget.autoReturnOnDetect && recognizedText.isNotEmpty) {
          // Stricter criteria: require at least 10 digits for Egyptian ID
          final hasIdNumber = RegExp(r'\d{10,14}').hasMatch(recognizedText);
          final hasArabic = RegExp(r'[أ-ي]').hasMatch(recognizedText);
          final hasEnglish = RegExp(r'[A-Za-z]{3,}').hasMatch(recognizedText);
          final hasNumbers = RegExp(r'\d{10,}').hasMatch(recognizedText); // Require at least 10 digits
          
          // Check if we have both ID number and name (better detection)
          final hasBothIdAndName = hasIdNumber && (hasArabic || hasEnglish);
          
          print('📝 Auto-return check: hasIdNumber=$hasIdNumber, hasArabic=$hasArabic, hasEnglish=$hasEnglish, hasNumbers=$hasNumbers, hasBothIdAndName=$hasBothIdAndName, length=${recognizedText.length}');
          
          // Stricter quality criteria: require meaningful ID data
          final isHighQuality = hasBothIdAndName && recognizedText.length > 30 && hasIdNumber;
          final isMediumQuality = hasIdNumber && recognizedText.length > 15; // Require at least 15 chars with ID number
          // Removed low quality auto-return - too lenient and causes issues
          
          if (isHighQuality) {
            print('✅ Auto-returning OCR text (high quality: ID + name detected)');
            // Return immediately for high quality detection
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && !_isOcrProcessing) {
                print('📤 Returning OCR text to form: ${recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length)}...');
                Navigator.of(context).pop(recognizedText);
              }
            });
          } else if (isMediumQuality) {
            print('✅ Auto-returning OCR text (medium quality: ID detected)');
            // Wait a bit longer for medium quality to see if more text appears
            Future.delayed(const Duration(milliseconds: 2000), () {
              if (mounted && _recognizedText == recognizedText && !_isOcrProcessing) {
                print('📤 Returning OCR text to form: ${recognizedText.substring(0, recognizedText.length > 100 ? 100 : recognizedText.length)}...');
                Navigator.of(context).pop(recognizedText);
              }
            });
          } else {
            print('⚠️ OCR text detected but does not meet quality criteria (need at least 10-digit ID number) - user can manually select or wait for better detection');
            // Don't auto-return, but keep the text available for manual selection
            // Show feedback to user
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Text detected but incomplete. Please ensure the full ID card is visible and in focus.'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
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

  /// Build text block overlays on camera view (Google Lens-like)
  List<Widget> _buildTextBlockOverlays() {
    if (_detectedTextBlocks == null || _detectedTextBlocks!.isEmpty) {
      return [];
    }
    
    final screenSize = MediaQuery.of(context).size;
    
    // Show all text blocks in a scrollable overlay at the top
    return [
      Positioned(
        top: 20,
        left: 20,
        right: 20,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: screenSize.height * 0.4,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.text_fields, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Detected Text - Tap to Select',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 20),
                      onPressed: () {
                        setState(() {
                          _detectedTextBlocks = null;
                          _recognizedText = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.white54, height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _detectedTextBlocks!.asMap().entries.map((entry) {
                      final block = entry.value;
                      final blockText = block.lines.map((line) => line.text).join(' ');
                      final isSelected = _selectedText == blockText;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedText = blockText;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? Colors.green.withOpacity(0.3)
                                : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? Colors.green : Colors.blue,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isSelected)
                                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                              if (isSelected) const SizedBox(width: 8),
                              Expanded(
                                child: SelectableText(
                                  blockText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void _onTextTap(String text) {
    setState(() {
      _selectedText = text;
    });
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
          // Text blocks overlay (Google Lens-like display)
          if (_detectedTextBlocks != null && _detectedTextBlocks!.isNotEmpty)
            ..._buildTextBlockOverlays(),
          
          // Selected text display with copy button
          if (_selectedText != null && _selectedText!.isNotEmpty)
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Text Selected',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedText = null;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SelectableText(
                        _selectedText!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _selectedText!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('✅ Text copied! Returning to form...'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (mounted) {
                              Navigator.of(context).pop(_selectedText);
                            }
                          });
                        },
                        icon: const Icon(Icons.copy, color: Colors.white),
                        label: const Text(
                          'Copy & Use',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // Capture button and instructions overlay
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Manual capture button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () {
                      print('📷 Manual capture button pressed');
                      _processCameraFrame();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isProcessing ? Colors.grey : const Color(0xFF81CF01),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                    ),
                    icon: _isProcessing 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.camera_alt, size: 28),
                    label: Text(
                      _isProcessing ? 'Processing...' : 'Capture',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Instructions
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.manualCaptureOnly
                        ? 'Position the ID card in frame and tap Capture to scan'
                        : 'Position the ID card in frame and tap Capture, or wait for auto-detection',
                    style: const TextStyle(
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

  /// Preprocess image for better OCR detection
  /// Applies moderate contrast enhancement and sharpening
  Future<String?> _preprocessImageForOCR(String imagePath) async {
    try {
      final file = File(imagePath);
      if (!await file.exists()) {
        print('❌ Image file does not exist for preprocessing: $imagePath');
        return null;
      }
      
      final bytes = await file.readAsBytes();
      var image = img.decodeImage(bytes);
      
      if (image == null) {
        print('❌ Could not decode image for preprocessing');
        return null;
      }
      
      print('🔄 Preprocessing image: ${image.width}x${image.height}');
      
      // Keep original image for comparison - don't convert to grayscale immediately
      // Some OCR engines work better with color images
      
      // Moderate contrast enhancement (1.2x instead of 1.5x)
      image = img.adjustColor(image, contrast: 1.2, brightness: 0.02);
      
      // Light sharpening (less aggressive)
      image = img.convolution(image, filter: [
        0, -0.5, 0,
        -0.5, 3, -0.5,
        0, -0.5, 0,
      ]);
      
      // Light contrast boost
      image = img.adjustColor(image, contrast: 1.1);
      
      // Save processed image
      final processedPath = '${imagePath}_processed.jpg';
      final processedBytes = img.encodeJpg(image, quality: 95);
      await File(processedPath).writeAsBytes(processedBytes);
      
      print('✅ Image preprocessed and saved: $processedPath (${processedBytes.length} bytes)');
      return processedPath;
    } catch (e, stackTrace) {
      print('❌ Error preprocessing image: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}

// Note: TextOverlayPainter removed - flutter_native_ocr doesn't provide bounding boxes
// Text is now displayed in a simple overlay container instead

