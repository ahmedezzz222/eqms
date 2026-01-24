# OpenCV Setup Instructions for Android

This app uses OpenCV for automatic ID card detection and perspective correction. Follow these steps to set up OpenCV:

## Option 1: Download OpenCV Android SDK (Recommended)

1. **Download OpenCV Android SDK:**
   - Visit: https://opencv.org/releases/
   - Download the latest Android pack (e.g., `opencv-4.8.0-android-sdk.zip`)

2. **Extract and Add to Project:**
   - Extract the downloaded ZIP file
   - Copy the `sdk` folder to `android/opencv/`
   - Your structure should be: `android/opencv/sdk/`

3. **Update `android/settings.gradle.kts`:**
   ```kotlin
   include(":opencv")
   project(":opencv").projectDir = file("opencv/sdk")
   ```

4. **Update `android/app/build.gradle.kts`:**
   ```kotlin
   dependencies {
       implementation(project(":opencv"))
   }
   ```

5. **Create `android/opencv/sdk/build.gradle.kts`:**
   ```kotlin
   plugins {
       id("com.android.library")
   }
   
   android {
       namespace = "org.opencv"
       compileSdk = 36
       
       defaultConfig {
           minSdk = 21
       }
       
       sourceSets {
           getByName("main") {
               jniLibs.srcDirs("native/libs")
               java.srcDirs("java/src")
               res.srcDirs("java/res")
           }
       }
   }
   ```

## Option 2: Use Pre-built AAR (Alternative)

1. **Download OpenCV AAR:**
   - Extract from OpenCV Android SDK: `sdk/native/libs/`
   - Or download from: https://mvnrepository.com/artifact/org.opencv/opencv-android

2. **Add to Project:**
   - Create `android/app/libs/` directory
   - Copy the AAR file to `android/app/libs/opencv-android.aar`

3. **Update `android/app/build.gradle.kts`:**
   ```kotlin
   dependencies {
       implementation(files("libs/opencv-android.aar"))
   }
   ```

## Option 3: Use Maven Repository (May Not Work)

If the above options don't work, you can try adding to `android/build.gradle.kts`:

```kotlin
allprojects {
    repositories {
        maven { url = uri("https://maven.aliyun.com/repository/public") }
        // or
        maven { url = uri("https://repo1.maven.org/maven2") }
    }
}
```

And in `android/app/build.gradle.kts`:
```kotlin
dependencies {
    implementation("org.opencv:opencv-android:4.8.0")
}
```

## Verification

After setup, the app will automatically:
1. Try to initialize OpenCV when processing ID card images
2. If OpenCV is available, it will use automatic card detection
3. If OpenCV is not available, it will fall back to manual cropping (existing behavior)

## Troubleshooting

- **"OpenCVLoader not found"**: Make sure OpenCV library is properly added to the project
- **"Native library not found"**: Ensure the native libraries (.so files) are in the correct location
- **Build errors**: Check that the OpenCV module/AAR is compatible with your Android SDK version

## Note

The app will gracefully handle the absence of OpenCV - if it's not available, it will simply use the existing manual cropping workflow.

