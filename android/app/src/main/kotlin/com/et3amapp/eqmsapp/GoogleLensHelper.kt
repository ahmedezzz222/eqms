package com.et3amapp.eqmsapp

import android.content.Intent
import android.content.pm.PackageManager
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
            val packageName = "com.google.android.googlequicksearchbox"
            val packageManager = activity.packageManager
            
            // Check if Google app is installed
            try {
                packageManager.getPackageInfo(packageName, 0)
            } catch (e: Exception) {
                resultCallback?.error(
                    "GOOGLE_LENS_NOT_INSTALLED",
                    "Google app is not installed. Please install Google app from Play Store.",
                    "Package: $packageName"
                )
                resultCallback = null
                return
            }
            
            // Method 1: Try direct Lens activity with component name (most reliable)
            // Try different possible activity names
            val possibleActivities = listOf(
                "com.google.android.apps.search.lens.LensActivity",
                "com.google.android.apps.lens.LensActivity",
                "com.google.android.apps.search.lens.LensEntryPointActivity",
                "com.google.android.apps.search.lens.LensLauncherActivity"
            )
            
            for (activityName in possibleActivities) {
                try {
                    val componentName = android.content.ComponentName(packageName, activityName)
                    val lensIntent1 = Intent().apply {
                        component = componentName
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    }
                    
                    activity.startActivity(lensIntent1)
                    android.util.Log.d("GoogleLensHelper", "Method 1 (Component: $activityName) succeeded")
                    resultCallback?.success("Google Lens camera opened. Please copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    android.util.Log.d("GoogleLensHelper", "Method 1 (Component: $activityName) failed: ${e.message}")
                }
            }
            
            // Method 2: Try direct Lens activity with action (try without resolveActivity check first)
            try {
                val lensIntent2 = Intent("com.google.android.apps.search.lens.LENS_ACTIVITY").apply {
                    setPackage(packageName)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                
                // Try to launch directly first (sometimes resolveActivity returns null but activity exists)
                try {
                    activity.startActivity(lensIntent2)
                    android.util.Log.d("GoogleLensHelper", "Method 2 (Action - direct) succeeded")
                    resultCallback?.success("Google Lens camera opened. Please copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    android.util.Log.d("GoogleLensHelper", "Method 2 (Action - direct) failed: ${e.message}, trying with resolveActivity check")
                    
                    // If direct launch fails, check if activity exists first
                    if (lensIntent2.resolveActivity(packageManager) != null) {
                        activity.startActivity(lensIntent2)
                        android.util.Log.d("GoogleLensHelper", "Method 2 (Action - with check) succeeded")
                        resultCallback?.success("Google Lens camera opened. Please copy the detected text.")
                        resultCallback = null
                        return
                    }
                }
            } catch (e: Exception) {
                android.util.Log.e("GoogleLensHelper", "Method 2 (Action) failed: ${e.message}")
            }
            
            // Method 3: Try Lens activity with custom URL scheme
            try {
                val lensIntent3 = Intent(Intent.ACTION_VIEW).apply {
                    setPackage(packageName)
                    data = Uri.parse("googlelens://")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                
                if (lensIntent3.resolveActivity(packageManager) != null) {
                    activity.startActivity(lensIntent3)
                    android.util.Log.d("GoogleLensHelper", "Method 3 (URL scheme) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.e("GoogleLensHelper", "Method 3 (URL scheme) failed: ${e.message}")
            }
            
            // Method 4: Try opening Google app with Lens URL
            try {
                val lensIntent4 = Intent(Intent.ACTION_VIEW).apply {
                    setPackage(packageName)
                    data = Uri.parse("https://lens.google.com")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                
                if (lensIntent4.resolveActivity(packageManager) != null) {
                    activity.startActivity(lensIntent4)
                    android.util.Log.d("GoogleLensHelper", "Method 4 (HTTPS URL) succeeded")
                    resultCallback?.success("Google app opened. Please use Lens feature and copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.e("GoogleLensHelper", "Method 4 (HTTPS URL) failed: ${e.message}")
            }
            
            // Method 5: Try opening Google app directly (user can navigate to Lens)
            try {
                val googleAppIntent = Intent(Intent.ACTION_MAIN).apply {
                    setPackage(packageName)
                    addCategory(Intent.CATEGORY_LAUNCHER)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                
                if (googleAppIntent.resolveActivity(packageManager) != null) {
                    activity.startActivity(googleAppIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 5 (Main launcher) succeeded")
                    resultCallback?.success("Google app opened. Please tap the Lens icon and copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.e("GoogleLensHelper", "Method 5 (Main launcher) failed: ${e.message}")
            }
            
            // If all methods fail, return error with helpful message
            resultCallback?.error(
                "GOOGLE_LENS_NOT_AVAILABLE",
                "Could not launch Google Lens. The app is installed but Lens feature may not be available. Please open Google app manually and use the Lens feature.",
                "Package: $packageName"
            )
            resultCallback = null
        } catch (e: Exception) {
            android.util.Log.e("GoogleLensHelper", "launchGoogleLensCamera error: ${e.message}", e)
            resultCallback?.error(
                "GOOGLE_LENS_ERROR",
                "Failed to launch Google Lens: ${e.message}",
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

