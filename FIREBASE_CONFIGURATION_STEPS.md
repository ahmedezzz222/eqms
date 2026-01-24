# Firebase Configuration Steps for Your App

## Your Firebase Project
**Project ID**: `et3am-ca94c`  
**Console URL**: https://console.firebase.google.com/u/0/project/et3am-ca94c

---

## Step 1: Download Firebase Configuration Files

### For Android:

1. **Go to Firebase Console**:
   - Open: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
   - Scroll down to "Your apps" section

2. **Add Android App** (if not already added):
   - Click the Android icon (or "Add app" → Android)
   - **Package name**: Check your `android/app/build.gradle.kts` file for `applicationId`
     - Usually: `com.example.eqmsapp` or similar
   - **App nickname**: `EQMS Android`
   - **Debug signing certificate SHA-1**: (Optional for now)
   - Click "Register app"

3. **Download `google-services.json`**:
   - Click "Download google-services.json"
   - Save the file

4. **Place the file**:
   - Copy `google-services.json` to: `android/app/google-services.json`
   - **Important**: It must be in `android/app/` folder, not `android/`

### For iOS:

1. **Add iOS App** (if not already added):
   - In Firebase Console, click "Add app" → iOS
   - **Bundle ID**: Check your `ios/Runner.xcodeproj` or `ios/Runner/Info.plist`
     - Usually: `com.example.eqmsapp` or similar
   - **App nickname**: `EQMS iOS`
   - Click "Register app"

2. **Download `GoogleService-Info.plist`**:
   - Click "Download GoogleService-Info.plist"
   - Save the file

3. **Add to Xcode**:
   - Open `ios/Runner.xcworkspace` in Xcode (NOT .xcodeproj)
   - Drag `GoogleService-Info.plist` into `ios/Runner/` folder in Xcode
   - Make sure "Copy items if needed" is checked
   - Make sure "Runner" target is selected

### For Web:

1. **Add Web App** (if not already added):
   - In Firebase Console, click "Add app" → Web
   - **App nickname**: `EQMS Web`
   - Click "Register app"

2. **Copy Firebase Config**:
   - You'll see a config object like:
   ```javascript
   const firebaseConfig = {
     apiKey: "YOUR_API_KEY",
     authDomain: "et3am-ca94c.firebaseapp.com",
     projectId: "et3am-ca94c",
     storageBucket: "et3am-ca94c.appspot.com",
     messagingSenderId: "YOUR_SENDER_ID",
     appId: "YOUR_APP_ID"
   };
   ```

---

## Step 2: Update Android Configuration

### Update `android/build.gradle.kts` (Project level):

Open `android/build.gradle.kts` and add to the `dependencies` block inside `buildscript`:

```kotlin
buildscript {
    dependencies {
        // ... existing dependencies
        classpath("com.google.gms:google-services:4.4.0")
    }
}
```

### Update `android/app/build.gradle.kts` (App level):

Open `android/app/build.gradle.kts` and add at the **top** of the file (after other plugins):

```kotlin
plugins {
    // ... existing plugins
    id("com.google.gms.google-services")
}
```

**Important**: The plugin must be at the bottom of the plugins block.

### Verify Package Name:

In `android/app/build.gradle.kts`, check that `applicationId` matches the package name you registered in Firebase:

```kotlin
android {
    defaultConfig {
        applicationId = "com.example.eqmsapp" // Must match Firebase
        // ...
    }
}
```

---

## Step 3: Update iOS Configuration

### Update Podfile:

Open `ios/Podfile` and ensure:

```ruby
platform :ios, '12.0'  # or higher
```

### Install Pods:

Open terminal in your project root and run:

```bash
cd ios
pod install
cd ..
```

### Update Info.plist (if needed):

Open `ios/Runner/Info.plist` and verify the bundle identifier matches Firebase.

---

## Step 4: Update Web Configuration

### Update `web/index.html`:

Open `web/index.html` and add before `</body>`:

```html
<!-- Firebase SDK -->
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-firestore-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-auth-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.1/firebase-storage-compat.js"></script>

<script>
  // Your Firebase config from Step 1
  const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "et3am-ca94c.firebaseapp.com",
    projectId: "et3am-ca94c",
    storageBucket: "et3am-ca94c.appspot.com",
    messagingSenderId: "YOUR_SENDER_ID",
    appId: "YOUR_APP_ID"
  };
  
  firebase.initializeApp(firebaseConfig);
</script>
```

---

## Step 5: Enable Firebase Services

### Enable Firestore:

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore
2. Click "Create database"
3. Choose "Start in test mode" (we'll update rules later)
4. Select location (choose closest to your users)
5. Click "Enable"

### Enable Authentication:

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/authentication
2. Click "Get started"
3. Enable "Email/Password" sign-in method
4. (Optional) Enable "Phone" sign-in method

### Enable Storage:

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/storage
2. Click "Get started"
3. Start in test mode
4. Select location (same as Firestore)
5. Click "Done"

---

## Step 6: Test the Connection

### Run the App:

```bash
flutter clean
flutter pub get
flutter run
```

### Check Console:

You should see in the console:
```
✅ Firebase initialized successfully
```

If you see:
```
⚠️ Firebase initialization failed
```

Check:
- `google-services.json` is in `android/app/`
- `GoogleService-Info.plist` is in `ios/Runner/`
- Package name/Bundle ID matches Firebase
- Firestore is enabled

---

## Step 7: Set Up Security Rules

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore/rules
2. Copy rules from `FIRESTORE_DATABASE_STRUCTURE.md`
3. Paste and click "Publish"

---

## Step 8: Create Collections (Optional)

You can either:
- Use the Setup Screen in your app
- Or create manually in Firebase Console

### Using Setup Screen:

1. In `lib/main.dart`, temporarily change:
   ```dart
   home: const SetupScreen(),
   ```
2. Run app and click "Setup Collections"
3. Change back to:
   ```dart
   home: const LoginScreen(),
   ```

---

## Quick Checklist

- [ ] `google-services.json` in `android/app/`
- [ ] `GoogleService-Info.plist` in `ios/Runner/`
- [ ] Android `build.gradle.kts` updated
- [ ] iOS pods installed
- [ ] Web `index.html` updated (if using web)
- [ ] Firestore enabled
- [ ] Authentication enabled
- [ ] Storage enabled
- [ ] App runs without errors
- [ ] Console shows "Firebase initialized successfully"

---

## Troubleshooting

### Android: "Default FirebaseApp is not initialized"

- Check `google-services.json` is in `android/app/`
- Verify package name matches
- Run `flutter clean` and rebuild

### iOS: "FirebaseApp.configure()" error

- Check `GoogleService-Info.plist` is in Xcode project
- Run `pod install` again
- Clean build folder in Xcode

### Web: Firebase not loading

- Check browser console for errors
- Verify scripts are loaded in `index.html`
- Check CORS settings if needed

### Still getting white screen?

- Check console for error messages
- Verify Firebase services are enabled
- Make sure configuration files are correct

---

## Next Steps

After configuration:
1. ✅ Test Firebase connection
2. ✅ Set up collections (use Setup Screen)
3. ✅ Update security rules
4. ✅ Create indexes (Firebase will prompt)
5. ✅ Start using your app with Firebase!

---

## Need Help?

- Check Firebase Console: https://console.firebase.google.com/u/0/project/et3am-ca94c
- Review error messages in console
- Verify all files are in correct locations
- Check package names/bundle IDs match

