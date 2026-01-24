# FlutterFire CLI Setup Guide

## Using FlutterFire CLI (Recommended for Multi-Platform)

This is the **easiest and recommended way** to configure Firebase for Android, iOS, and Web all at once!

---

## Prerequisites

1. **Node.js installed** (for FlutterFire CLI)
   - Download: https://nodejs.org/
   - Verify: `node --version`

2. **Firebase CLI installed**
   ```bash
   npm install -g firebase-tools
   ```

3. **Logged into Firebase**
   ```bash
   firebase login
   ```

---

## Step 1: Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

**Note**: Make sure Flutter's pub cache is in your PATH:
- Windows: Add `%LOCALAPPDATA%\Pub\Cache\bin` to PATH
- Mac/Linux: Add `~/.pub-cache/bin` to PATH

Or use full path:
```bash
flutter pub global run flutterfire_cli:configure
```

---

## Step 2: Configure Firebase for Your App

### Option A: Interactive Setup (Recommended)

```bash
flutterfire configure
```

This will:
1. Ask you to select your Firebase project: **et3am-ca94c**
2. Automatically detect your platforms (Android, iOS, Web)
3. Download and place configuration files:
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`
   - `lib/firebase_options.dart` (for web)
4. Update your code automatically

### Option B: Non-Interactive Setup

```bash
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

---

## Step 3: Update Your Code

After running `flutterfire configure`, you need to update `main.dart`:

### Update `lib/main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // This file is auto-generated

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Auto-detects platform
  );
  
  await FirebaseService.initialize();
  
  runApp(const MyApp());
}
```

---

## Step 4: Verify Configuration

### Check Generated Files:

- ✅ `android/app/google-services.json` - Should exist
- ✅ `ios/Runner/GoogleService-Info.plist` - Should exist
- ✅ `lib/firebase_options.dart` - Should exist (for web)

### Check `lib/firebase_options.dart`:

This file should contain your Firebase config for all platforms:
```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // ...
    }
  }
  
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '...',
    appId: '...',
    messagingSenderId: '...',
    projectId: 'et3am-ca94c',
    // ...
  );
  
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '...',
    appId: '...',
    messagingSenderId: '...',
    projectId: 'et3am-ca94c',
    // ...
  );
  
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '...',
    appId: '...',
    messagingSenderId: '...',
    projectId: 'et3am-ca94c',
    // ...
  );
}
```

---

## Step 5: Update main.dart

Let me update your `main.dart` to use the FlutterFire configuration:

