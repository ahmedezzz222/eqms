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
     * This opens Google Lens app directly (not URL/browser)
     */
    fun launchGoogleLensCamera(result: MethodChannel.Result) {
        resultCallback = result
        
        try {
            val packageManager = activity.packageManager
            
            // Method 0a: Implicit intent - open any app that handles googlelens:// (do NOT use MATCH_DEFAULT_ONLY; on Samsung/etc. no default may be set)
            try {
                val implicitLens = Intent(Intent.ACTION_VIEW).apply {
                    data = Uri.parse("googlelens://")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                var resolve = packageManager.resolveActivity(implicitLens, 0)
                if (resolve == null) {
                    // Fallback: query all activities that handle googlelens:// and launch the first one (Samsung A54 etc.)
                    @Suppress("DEPRECATION")
                    val list = packageManager.queryIntentActivities(implicitLens, 0)
                    if (list.isNotEmpty()) {
                        val first = list[0]
                        implicitLens.setPackage(first.activityInfo.packageName)
                        activity.startActivity(implicitLens)
                        android.util.Log.d("GoogleLensHelper", "Method 0a (queryIntentActivities) succeeded: ${first.activityInfo.packageName}")
                        resultCallback?.success("Google Lens opened. Please copy the detected text.")
                        resultCallback = null
                        return
                    }
                } else {
                    activity.startActivity(implicitLens)
                    android.util.Log.d("GoogleLensHelper", "Method 0a (Implicit googlelens://) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.d("GoogleLensHelper", "Method 0a (Implicit) failed: ${e.message}")
            }
            
            // Method 0a2: Try standalone Lens from Play Store (com.google.ar.lens) - common on Samsung/other devices
            val arLensPackage = "com.google.ar.lens"
            try {
                packageManager.getPackageInfo(arLensPackage, 0)
                val mainIntent = packageManager.getLaunchIntentForPackage(arLensPackage)
                if (mainIntent != null) {
                    mainIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    activity.startActivity(mainIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 0a2 (com.google.ar.lens launcher) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
                val viewIntent = Intent(Intent.ACTION_VIEW).apply {
                    setPackage(arLensPackage)
                    data = Uri.parse("googlelens://")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                if (viewIntent.resolveActivity(packageManager) != null) {
                    activity.startActivity(viewIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 0a2 (com.google.ar.lens googlelens://) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.d("GoogleLensHelper", "Method 0a2 (com.google.ar.lens) not available: ${e.message}")
            }

            // Method 0b: Try standalone Google Lens app (com.google.android.apps.lens)
            val standaloneLensPackage = "com.google.android.apps.lens"
            try {
                packageManager.getPackageInfo(standaloneLensPackage, 0)
                val mainIntent = packageManager.getLaunchIntentForPackage(standaloneLensPackage)
                if (mainIntent != null) {
                    mainIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    activity.startActivity(mainIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 0b (Standalone Lens app) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
                // Standalone app installed but no launcher - try VIEW with googlelens:// and package
                val viewIntent = Intent(Intent.ACTION_VIEW).apply {
                    setPackage(standaloneLensPackage)
                    data = Uri.parse("googlelens://")
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                }
                if (viewIntent.resolveActivity(packageManager) != null) {
                    activity.startActivity(viewIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 0b (Standalone googlelens://) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.d("GoogleLensHelper", "Method 0b (Standalone Lens) not available: ${e.message}")
            }
            
            // Method 0c: Search for any installed app with "lens" in package name and try to launch
            try {
                val installed = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)
                for (app in installed) {
                    if (app.packageName.lowercase().contains("lens")) {
                        val launch = packageManager.getLaunchIntentForPackage(app.packageName)
                        if (launch != null) {
                            launch.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            activity.startActivity(launch)
                            android.util.Log.d("GoogleLensHelper", "Method 0c (Found lens package: ${app.packageName}) succeeded")
                            resultCallback?.success("Google Lens opened. Please copy the detected text.")
                            resultCallback = null
                            return
                        }
                    }
                }
            } catch (e: Exception) {
                android.util.Log.d("GoogleLensHelper", "Method 0c (Query packages) failed: ${e.message}")
            }
            
            val packageName = "com.google.android.googlequicksearchbox"
            try {
                packageManager.getPackageInfo(packageName, 0)
            } catch (e: Exception) {
                resultCallback?.error(
                    "GOOGLE_LENS_NOT_INSTALLED",
                    "Google Lens could not be opened. Using in-app camera instead.",
                    "Package: $packageName"
                )
                resultCallback = null
                return
            }
            
            // Method 1: Try direct Lens activity with component name (most reliable)
            val possibleActivities = listOf(
                "com.google.android.apps.search.lens.LensActivity",
                "com.google.android.apps.lens.LensActivity",
                "com.google.android.apps.search.lens.LensEntryPointActivity",
                "com.google.android.apps.search.lens.LensLauncherActivity",
                "com.google.android.apps.search.lens.LensActivityWithCamera",
                "com.google.vr.apps.opus.lens.LensActivity"
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
            
            // Method 1b: Same activities but for standalone Lens package
            for (activityName in listOf(
                "com.google.android.apps.lens.LensActivity",
                "com.google.android.apps.lens.camera.LensActivity"
            )) {
                try {
                    val componentName = android.content.ComponentName(standaloneLensPackage, activityName)
                    val lensIntent = Intent().apply {
                        component = componentName
                        addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                    }
                    activity.startActivity(lensIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 1b (Standalone component: $activityName) succeeded")
                    resultCallback?.success("Google Lens opened. Please copy the detected text.")
                    resultCallback = null
                    return
                } catch (e: Exception) {
                    android.util.Log.d("GoogleLensHelper", "Method 1b ($activityName) failed: ${e.message}")
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
            
            // Method 4: Try opening Google app launcher (user can tap Lens icon)
            try {
                val googleAppIntent = Intent(Intent.ACTION_MAIN).apply {
                    setPackage(packageName)
                    addCategory(Intent.CATEGORY_LAUNCHER)
                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                }
                
                if (googleAppIntent.resolveActivity(packageManager) != null) {
                    activity.startActivity(googleAppIntent)
                    android.util.Log.d("GoogleLensHelper", "Method 4 (Main launcher) succeeded")
                    resultCallback?.success("Google app opened. Please tap the Lens icon and copy the detected text.")
                    resultCallback = null
                    return
                }
            } catch (e: Exception) {
                android.util.Log.e("GoogleLensHelper", "Method 4 (Main launcher) failed: ${e.message}")
            }
            
            // If all methods fail, return error with helpful message
            resultCallback?.error(
                "GOOGLE_LENS_NOT_AVAILABLE",
                "Google Lens could not be opened. Using in-app camera instead.",
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

