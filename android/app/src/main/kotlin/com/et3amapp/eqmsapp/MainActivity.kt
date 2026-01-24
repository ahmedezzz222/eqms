package com.et3amapp.eqmsapp

import android.content.Intent
import android.nfc.NfcAdapter
import android.nfc.Tag
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val DOCUMENT_SCANNER_CHANNEL = "com.et3amapp.eqmsapp/document_scanner"
    private val GOOGLE_LENS_CHANNEL = "com.et3amapp.eqmsapp/google_lens"
    private lateinit var documentScannerHelper: DocumentScannerHelper
    private lateinit var googleLensHelper: GoogleLensHelper
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize Document Scanner Helper
        documentScannerHelper = DocumentScannerHelper(this)
        
        // Initialize Google Lens Helper
        googleLensHelper = GoogleLensHelper(this)
        
        // Note: OpenCV has been removed - now using egyptian_id_parser package directly
        
        // Document Scanner channel (Google Lens-like automatic detection)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DOCUMENT_SCANNER_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "scanDocument" -> {
                    // Launch ML Kit Document Scanner (Google Lens-like)
                    documentScannerHelper.scanDocument(result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Google Lens channel (launch Google Lens app directly)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GOOGLE_LENS_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "launchGoogleLens" -> {
                    val imagePath = call.argument<String>("imagePath")
                    if (imagePath != null) {
                        googleLensHelper.launchGoogleLens(imagePath, result)
                    } else {
                        result.error("INVALID_ARGUMENT", "imagePath is required", null)
                    }
                }
                "launchGoogleLensCamera" -> {
                    googleLensHelper.launchGoogleLensCamera(result)
                }
                "isGoogleLensAvailable" -> {
                    val isAvailable = googleLensHelper.isGoogleLensAvailable()
                    result.success(isAvailable)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Handle NFC intent if app was launched by NFC tag
        handleNfcIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Always call setIntent to update the intent reference
        // This is required for singleTop launch mode to work correctly
        setIntent(intent)
        // Handle NFC intent - consume it to prevent "Complete action with" popup
        handleNfcIntent(intent)
    }
    
    override fun onResume() {
        super.onResume()
        // Handle NFC intent when activity resumes
        handleNfcIntent(intent)
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        // Handle Document Scanner result
        if (requestCode == DocumentScannerHelper.SCAN_REQUEST_CODE) {
            documentScannerHelper.handleActivityResult(requestCode, resultCode, data)
        }
    }
    
    private fun handleNfcIntent(intent: Intent?) {
        // Check if intent is an NFC intent
        if (intent != null && (
            NfcAdapter.ACTION_TAG_DISCOVERED == intent.action ||
            NfcAdapter.ACTION_NDEF_DISCOVERED == intent.action ||
            NfcAdapter.ACTION_TECH_DISCOVERED == intent.action
        )) {
            // NFC intent received - consume it to prevent "Complete action with" popup
            // Extract tag from intent to consume it
            val tag: Tag? = intent.getParcelableExtra(NfcAdapter.EXTRA_TAG)
            if (tag != null) {
                // Tag is consumed - this prevents Android from showing the popup
                // The flutter_nfc_reader plugin will handle the tag via reader mode
                println("NFC: Intent received and consumed - tag ID: ${tag.id?.contentToString()}")
            }
        }
    }
}

