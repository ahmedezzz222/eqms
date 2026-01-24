package com.et3amapp.eqmsapp

import android.app.Activity
import android.content.Intent
import android.content.IntentSender
import android.net.Uri
import android.os.Bundle
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

/**
 * Google ML Kit Document Scanner Helper
 * Provides Google Lens-like automatic document detection with built-in UI
 * 
 * Features:
 * - Automatic edge detection
 * - Perspective correction
 * - Built-in cropping UI
 * - Works offline
 */
class DocumentScannerHelper(private val activity: FlutterActivity) {
    companion object {
        const val SCAN_REQUEST_CODE = 1001
    }
    
    private var resultCallback: MethodChannel.Result? = null
    
    /**
     * Launch ML Kit Document Scanner
     * This provides a Google Lens-like experience with automatic document detection
     */
    fun scanDocument(result: MethodChannel.Result) {
        resultCallback = result
        
        try {
            // Configure Document Scanner options
            val options = GmsDocumentScannerOptions.Builder()
                .setScannerMode(GmsDocumentScannerOptions.SCANNER_MODE_FULL) // Full mode for best results
                .setGalleryImportAllowed(true) // Allow importing from gallery
                .setPageLimit(1) // Only scan one page (ID card)
                .setResultFormats(
                    GmsDocumentScannerOptions.RESULT_FORMAT_JPEG // JPEG output
                )
                .build()
            
            // Get document scanner instance
            val scanner = GmsDocumentScanning.getClient(options)
            
            // Start scanner - getStartScanIntent returns Task<IntentSender>
            scanner.getStartScanIntent(activity)
                .addOnSuccessListener { intentSender ->
                    try {
                        // Use startIntentSenderForResult to launch the scanner
                        activity.startIntentSenderForResult(
                            intentSender,
                            SCAN_REQUEST_CODE,
                            null,
                            0,
                            0,
                            0,
                            null
                        )
                    } catch (e: Exception) {
                        resultCallback?.error(
                            "SCAN_ERROR",
                            "Failed to launch scanner: ${e.message}",
                            e.toString()
                        )
                        resultCallback = null
                    }
                }
                .addOnFailureListener { exception ->
                    resultCallback?.error(
                        "SCAN_ERROR",
                        "Failed to start scanner: ${exception.message}",
                        exception.toString()
                    )
                    resultCallback = null
                }
        } catch (e: Exception) {
            resultCallback?.error(
                "SCAN_ERROR",
                "Document scanner not available: ${e.message}",
                e.toString()
            )
            resultCallback = null
        }
    }
    
    /**
     * Handle scan result from activity
     * This should be called from MainActivity.onActivityResult
     */
    fun handleActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode != SCAN_REQUEST_CODE) {
            return
        }
        
        if (resultCode == Activity.RESULT_OK && data != null) {
            try {
                val result = GmsDocumentScanningResult.fromActivityResultIntent(data)
                
                if (result != null && result.pages?.isNotEmpty() == true) {
                    // Get the scanned image
                    val page = result.pages!![0]
                    val imageUri = page.imageUri
                    
                    // Copy image to app's cache directory and return path
                    val imagePath = copyImageToCache(imageUri)
                    
                    if (imagePath != null) {
                        resultCallback?.success(imagePath)
                    } else {
                        resultCallback?.error(
                            "SCAN_ERROR",
                            "Failed to save scanned image",
                            null
                        )
                    }
                } else {
                    resultCallback?.error(
                        "SCAN_ERROR",
                        "No document detected",
                        null
                    )
                }
            } catch (e: Exception) {
                resultCallback?.error(
                    "SCAN_ERROR",
                    "Error processing scan result: ${e.message}",
                    e.toString()
                )
            }
        } else {
            // User cancelled
            resultCallback?.success(null)
        }
        resultCallback = null
    }
    
    /**
     * Copy scanned image from URI to app cache directory
     */
    private fun copyImageToCache(uri: Uri): String? {
        return try {
            val cacheDir = activity.cacheDir
            val outputFile = File(cacheDir, "scanned_document_${System.currentTimeMillis()}.jpg")
            
            activity.contentResolver.openInputStream(uri)?.use { inputStream ->
                FileOutputStream(outputFile).use { outputStream ->
                    inputStream.copyTo(outputStream)
                }
            }
            
            outputFile.absolutePath
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }
}

