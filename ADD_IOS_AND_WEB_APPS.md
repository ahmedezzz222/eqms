# Add iOS and Web Apps to Firebase - Step by Step

## Your Firebase Project
**Project**: `et3am-ca94c`  
**Console**: https://console.firebase.google.com/u/0/project/et3am-ca94c

---

## Step 1: Add iOS App

### 1.1 Go to Firebase Console
https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general

### 1.2 Add iOS App
1. Scroll down to **"Your apps"** section
2. Click **"Add app"** → **iOS** (Apple icon 🍎)

### 1.3 Enter iOS App Information
- **iOS bundle ID**: `com.example.eqmsapp` ⬅️ **Use this exact value**
- **App nickname (optional)**: `EQMS iOS`
- **App Store ID** (optional): Leave blank

### 1.4 Register App
1. Click **"Register app"**
2. **Download `GoogleService-Info.plist`** - Save this file (we'll place it later)
3. Click **"Next"** through the remaining steps (you can skip them for now)

**✅ iOS app is now registered!**

---

## Step 2: Add Web App

### 2.1 Still in Firebase Console
1. Click **"Add app"** → **Web** (</> icon)

### 2.2 Enter Web App Information
- **App nickname**: `EQMS Web`
- **Firebase Hosting** (optional): Leave **unchecked** for now

### 2.3 Register App
1. Click **"Register app"**
2. **Copy the Firebase config** - You'll see a config object like this:
   ```javascript
   const firebaseConfig = {
     apiKey: "AIzaSy...",
     authDomain: "et3am-ca94c.firebaseapp.com",
     projectId: "et3am-ca94c",
     storageBucket: "et3am-ca94c.appspot.com",
     messagingSenderId: "123456789",
     appId: "1:123456789:web:abc123def456"
   };
   ```
   - **Save this config** (we'll use it later, but FlutterFire CLI will handle it automatically)

3. Click **"Next"** - You can skip the remaining steps

**✅ Web app is now registered!**

---

## Step 3: Verify All Apps Are Added

Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general

Scroll to **"Your apps"** section - you should see:
- ✅ **Android** app (already added)
- ✅ **iOS** app (just added)
- ✅ **Web** app (just added)

---

## Step 4: Run FlutterFire CLI

Now that all apps are added, run FlutterFire CLI to configure everything:

```powershell
# Make sure you're in project root
cd D:\XYZ\Docs\DevArea\eqmsapp

# Run FlutterFire configure
flutterfire configure
```

**What will happen:**
1. It will show your Firebase projects
2. Select: **et3am-ca94c**
3. It will detect all three apps (Android, iOS, Web)
4. Automatically download and place configuration files:
   - ✅ `android/app/google-services.json` (already exists, will be verified)
   - ✅ `ios/Runner/GoogleService-Info.plist` (will be downloaded)
   - ✅ `lib/firebase_options.dart` (will be created with all platform configs)
5. Update build files if needed

---

## Step 5: After FlutterFire Configure

After `flutterfire configure` completes:

1. **Uncomment the import** in `lib/main.dart`:
   ```dart
   import 'firebase_options.dart'; // Uncomment this
   ```

2. **Update Firebase initialization** in `lib/main.dart`:
   ```dart
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

3. **Run the app**:
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

---

## Quick Checklist

- [ ] iOS app added to Firebase Console
  - Bundle ID: `com.example.eqmsapp`
  - `GoogleService-Info.plist` downloaded
- [ ] Web app added to Firebase Console
  - App nickname: `EQMS Web`
  - Firebase config copied (optional, FlutterFire will handle it)
- [ ] All three apps visible in Firebase Console
- [ ] Ready to run `flutterfire configure`

---

## Troubleshooting

### "Bundle ID not found" in FlutterFire
- Make sure iOS app is added with exact bundle ID: `com.example.eqmsapp`
- Check Firebase Console to verify

### "Web app not detected"
- Make sure Web app is added in Firebase Console
- FlutterFire CLI should detect it automatically

### FlutterFire CLI errors
- Make sure you're logged in: `firebase login`
- Make sure you're in project root directory
- Try: `flutter pub global run flutterfire_cli:configure`

---

**After adding iOS and Web apps, let me know and I'll help you run `flutterfire configure`!** 🚀

