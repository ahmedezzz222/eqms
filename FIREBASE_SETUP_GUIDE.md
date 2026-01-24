# Firebase Setup Guide for EQMS App

## Prerequisites
- Flutter SDK installed
- Firebase account
- Android Studio / Xcode (for platform-specific setup)

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter project name: `eqms-app` (or your preferred name)
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Add Firebase to Your Flutter App

### For Android:

1. **Register Android App**:
   - In Firebase Console, click "Add app" → Android
   - Package name: `com.example.eqmsapp` (check your `android/app/build.gradle.kts` for actual package name)
   - App nickname: `EQMS Android`
   - Download `google-services.json`
   - Place it in `android/app/` directory

2. **Update Android Build Files**:
   - Open `android/build.gradle.kts` (project level)
   - Add to `dependencies`:
     ```kotlin
     classpath("com.google.gms:google-services:4.4.0")
     ```
   
   - Open `android/app/build.gradle.kts` (app level)
   - Add at the top:
     ```kotlin
     plugins {
         id("com.google.gms.google-services")
     }
     ```

### For iOS:

1. **Register iOS App**:
   - In Firebase Console, click "Add app" → iOS
   - Bundle ID: `com.example.eqmsapp` (check your `ios/Runner.xcodeproj` for actual bundle ID)
   - App nickname: `EQMS iOS`
   - Download `GoogleService-Info.plist`
   - Open Xcode, drag `GoogleService-Info.plist` into `ios/Runner/` directory
   - Make sure "Copy items if needed" is checked

2. **Update iOS Podfile**:
   - Open `ios/Podfile`
   - Uncomment `platform :ios, '12.0'` (or higher)
   - Run `cd ios && pod install`

### For Web:

1. **Register Web App**:
   - In Firebase Console, click "Add app" → Web
   - App nickname: `EQMS Web`
   - Copy the Firebase configuration object

2. **Update Web Index**:
   - Open `web/index.html`
   - Add Firebase SDK scripts before `</body>`:
     ```html
     <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js"></script>
     <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-firestore-compat.js"></script>
     <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-auth-compat.js"></script>
     <script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-storage-compat.js"></script>
     <script>
       // Your Firebase config will be here
       const firebaseConfig = {
         apiKey: "YOUR_API_KEY",
         authDomain: "YOUR_AUTH_DOMAIN",
         projectId: "YOUR_PROJECT_ID",
         storageBucket: "YOUR_STORAGE_BUCKET",
         messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
         appId: "YOUR_APP_ID"
       };
       firebase.initializeApp(firebaseConfig);
     </script>
     ```

## Step 3: Enable Firebase Services

### Enable Firestore Database:

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (we'll update security rules later)
4. Select location (choose closest to your users)
5. Click "Enable"

### Enable Firebase Authentication:

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Enable "Email/Password" sign-in method
4. Enable "Phone" sign-in method (optional, for mobile login)

### Enable Firebase Storage:

1. In Firebase Console, go to "Storage"
2. Click "Get started"
3. Start in test mode
4. Select location (same as Firestore)
5. Click "Done"

## Step 4: Install Flutter Dependencies

Run in your project root:
```bash
flutter pub get
```

## Step 5: Initialize Firebase in Your App

Update `lib/main.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.initialize();
  runApp(const MyApp());
}
```

## Step 6: Configure Firestore Security Rules

1. In Firebase Console, go to "Firestore Database" → "Rules"
2. Copy the security rules from `FIRESTORE_DATABASE_STRUCTURE.md`
3. Paste and click "Publish"

## Step 7: Create Firestore Indexes

Firebase will automatically prompt you to create indexes when needed. Alternatively:

1. Go to "Firestore Database" → "Indexes"
2. Create composite indexes as listed in `FIRESTORE_DATABASE_STRUCTURE.md`

## Step 8: Test Firebase Connection

Create a test file `lib/test_firebase.dart`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> testFirebase() async {
  try {
    await FirebaseFirestore.instance
        .collection('test')
        .doc('test')
        .set({'message': 'Firebase is working!'});
    print('Firebase connection successful!');
  } catch (e) {
    print('Firebase connection failed: $e');
  }
}
```

## Step 9: Update App to Use Firestore

The service classes are ready in `lib/services/`. You can now:

1. Replace in-memory data with Firestore streams
2. Use service methods for CRUD operations
3. Update UI to listen to Firestore streams

## Troubleshooting

### Android Issues:

- **Build Error**: Make sure `google-services.json` is in `android/app/`
- **Gradle Sync Error**: Update Google Services plugin version
- **Package Name Mismatch**: Check package name in `build.gradle.kts` matches Firebase

### iOS Issues:

- **Pod Install Error**: Run `cd ios && pod repo update && pod install`
- **Missing GoogleService-Info.plist**: Make sure it's added to Xcode project
- **Build Error**: Clean build folder in Xcode

### Web Issues:

- **CORS Error**: Configure Firebase Storage CORS rules
- **Script Loading**: Check browser console for script errors

## Next Steps

1. Review `FIRESTORE_DATABASE_STRUCTURE.md` for database schema
2. Update your app screens to use Firestore services
3. Test all CRUD operations
4. Set up proper authentication flow
5. Configure Firebase Storage for file uploads

## Support

For issues:
- Check Firebase Console for error logs
- Review Flutter Firebase documentation
- Check service class implementations in `lib/services/`

