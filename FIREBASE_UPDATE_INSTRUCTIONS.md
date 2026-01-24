# 🔥 Update Firebase Apps with New Package Names

## Quick Steps to Update Firebase Console

### Step 1: Update Android App

1. **Open Firebase Console**
   - Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general

2. **Find Your Android App**
   - Look for the Android app (should show package `com.example.eqmsapp`)

3. **Add New Package Name**
   - Click the ⚙️ (gear/settings) icon next to the Android app
   - Scroll down to find "Your apps" section
   - Click **"Add another package name"** button
   - Enter: `com.et3am.eqmsapp`
   - Click **"Register app"**

4. **Download New Config File**
   - After registering, you'll see a download button for `google-services.json`
   - Click **"Download google-services.json"**
   - Save it and replace the file at: `android/app/google-services.json`

---

### Step 2: Update iOS App

1. **Find Your iOS App**
   - In the same Firebase Console page, find the iOS app (should show bundle ID `com.example.eqmsapp`)

2. **Add New Bundle ID**
   - Click the ⚙️ (gear/settings) icon next to the iOS app
   - Scroll down to find "Your apps" section
   - Click **"Add another bundle ID"** button
   - Enter: `com.et3am.eqmsapp`
   - Click **"Register app"**

3. **Download New Config File**
   - After registering, you'll see a download button for `GoogleService-Info.plist`
   - Click **"Download GoogleService-Info.plist"**
   - Save it and replace the file at: `ios/Runner/GoogleService-Info.plist` (or `ios/Flutter/GoogleService-Info.plist`)

---

### Step 3: Re-run FlutterFire Configure

After updating both apps in Firebase Console, run:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will automatically:
- Detect the new package/bundle IDs
- Update `firebase_options.dart` with the correct configs
- Link everything properly

---

## Alternative: Create New Apps (If "Add another" doesn't work)

If you can't find the "Add another package name/bundle ID" option:

### Create New Android App:
1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
2. Click **"Add app"** → Select **Android**
3. **Android package name**: `com.et3am.eqmsapp`
4. **App nickname** (optional): `eqmsapp-android`
5. Click **"Register app"**
6. Download `google-services.json` → Replace `android/app/google-services.json`

### Create New iOS App:
1. Click **"Add app"** → Select **iOS**
2. **iOS bundle ID**: `com.et3am.eqmsapp`
3. **App nickname** (optional): `eqmsapp-ios`
4. Click **"Register app"**
5. Download `GoogleService-Info.plist` → Place in `ios/Runner/`

---

## After Updating Firebase

Once you've updated the Firebase Console apps and downloaded the new config files:

1. **Replace the config files** in your project
2. **Run FlutterFire configure**:
   ```powershell
   flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
   ```
3. **Clean and rebuild**:
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

---

## Need Help?

If you want me to help you navigate the Firebase Console using browser automation, let me know and I can guide you through it step-by-step!

