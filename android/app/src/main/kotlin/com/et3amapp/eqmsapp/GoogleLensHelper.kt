package com.et3amapp.eqmsapp

import android.content.Intent
import android.net.Uri
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File

/**
 * Google Lens Helper
 * Launches Google Lens app for text recognition and translation
 * 
 * Note: Google Lens doesn't provide a direct API to get results back,
 * but we can launch it and let users copy the detected text.
 */
class GoogleLensHelper(private val activity: FlutterActivity) {
    private var resultCallback: MethodChannel.Result? = null
    
    /**
     * Launch Google Lens app with an image
     * This opens Google Lens where users can see detected text and copy it
     */
    fun launchGoogleLens(imagePath: String, result: MethodChannel.Result) {
        resultCallback = result
        
        try {
            val imageFile = File(imagePath)
            if (!imageFile.exists()) {
                resultCallback?.error(
                    "FILE_NOT_FOUND",
                    "Image file not found: $imagePath",
                    null
                )
                resultCallback = null
                return
            }
            
            // Use FileProvider for secure file sharing (required for Android 7.0+)
            val imageUri = FileProvider.getUriForFile(
                activity,
                "${activity.packageName}.fileprovider",
                imageFile
            )
            
            // Try to launch Google Lens app directly using share intent
            // This is more reliable than direct package launch
            val lensPackage = "com.google.android.googlequicksearchbox"
            val lensIntent = Intent(Intent.ACTION_SEND).apply {
                setPackage(lensPackage)
                type = "image/*"
                putExtra(Intent.EXTRA_STREAM, imageUri)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            }
            
            // Check if Google Lens is available
            if (lensIntent.resolveActivity(activity.packageManager) != null) {
                // Launch Google Lens directly
                activity.startActivity(lensIntent)
                resultCallback?.success("Google Lens opened. Please copy the detected text.")
            } else {
                // Fallback: Show share chooser (user can select Google Lens)
                val shareIntent = Intent(Intent.ACTION_SEND).apply {
                    type = "image/*"
                    putExtra(Intent.EXTRA_STREAM, imageUri)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                }
                val chooser = Intent.createChooser(shareIntent, "Open with Google Lens")
                chooser.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                activity.startActivity(chooser)
                resultCallback?.success("Share menu opened. Please select Google Lens.")
            }
            resultCallback = null
        } catch (e: Exception) {
            resultCallback?.error(
                "GOOGLE_LENS_ERROR",
                "Failed to launch Google Lens: ${e.message}",
                e.toString()
            )
            resultCallback = null
        }
    }
    
    /**
     * Launch Google Lens with camera (live view)
     * This opens Google Lens camera view directly
     */
    fun launchGoogleLensCamera(result: MethodChannel.Result) {
        resultCallback = result
        
        try {
            // Try multiple methods to launch Google Lens
            
            // Method 1: Try direct Lens activity
            val lensIntent1 = Intent(Intent.ACTION_VIEW).apply {
                setPackage("com.google.android.googlequicksearchbox")
                setAction("com.google.android.apps.search.lens.LENS_ACTIVITY")
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            
            if (lensIntent1.resolveActivity(activity.packageManager) != null) {
                try {
                    activity.startActivity(lensIntent1)
                    resultCallback?.success("Google Lens camera opened. Please copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    // Continue to next method
                }
            }
            
            // Method 2: Try opening Google app with Lens intent
            val lensIntent2 = Intent(Intent.ACTION_VIEW).apply {
                setPackage("com.google.android.googlequicksearchbox")
                setData(Uri.parse("https://lens.google.com"))
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            
            if (lensIntent2.resolveActivity(activity.packageManager) != null) {
                try {
                    activity.startActivity(lensIntent2)
                    resultCallback?.success("Google app opened. Please use Lens feature and copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    // Continue to next method
                }
            }
            
            // Method 3: Try opening Google app directly
            val googleAppIntent = Intent(Intent.ACTION_MAIN).apply {
                setPackage("com.google.android.googlequicksearchbox")
                addCategory(Intent.CATEGORY_LAUNCHER)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            
            if (googleAppIntent.resolveActivity(activity.packageManager) != null) {
                try {
                    activity.startActivity(googleAppIntent)
                    resultCallback?.success("Google app opened. Please use Lens feature from the app and copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    // Continue to error
                }
            }
            
            // If all methods fail, return error with helpful message
            resultCallback?.error(
                "GOOGLE_LENS_NOT_AVAILABLE",
                "Google Lens is not available on this device. Please install Google app from Play Store, or use the 'Scan ID' button for OCR detection.",
                "Google app package: com.google.android.googlequicksearchbox"
            )
            resultCallback = null
        } catch (e: Exception) {
            resultCallback?.error(
                "GOOGLE_LENS_ERROR",
                "Failed to launch Google Lens: ${e.message}. Please use the 'Scan ID' button for OCR detection instead.",
                e.toString()
            )
            resultCallback = null
        }
    }
    
    /**
     * Check if Google Lens is available on the device
     */
    fun isGoogleLensAvailable(): Boolean {
        return try {
            // Check if Google app package is installed
            val packageManager = activity.packageManager
            val googleAppPackage = "com.google.android.googlequicksearchbox"
            
            // Try to get package info
            packageManager.getPackageInfo(googleAppPackage, 0)
            
            // Check if Lens activity is available
            val lensIntent = Intent(Intent.ACTION_VIEW).apply {
                setPackage(googleAppPackage)
                setAction("com.google.android.apps.search.lens.LENS_ACTIVITY")
            }
            
            lensIntent.resolveActivity(packageManager) != null
        } catch (e: Exception) {
            false
        }
    }
}

