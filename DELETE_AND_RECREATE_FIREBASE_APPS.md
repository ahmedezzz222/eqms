# 🔄 Delete and Recreate Firebase Apps

## Overview

We'll delete the existing Android and iOS apps from Firebase Console and create fresh ones with the correct package/bundle IDs:
- **Android**: `com.et3am.eqmsapp`
- **iOS**: `com.et3am.eqmsapp`

---

## Step 1: Delete Existing Apps

### Delete Android App(s)

1. **Go to Firebase Console**
   - https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general

2. **Find Android Apps**
   - Scroll to "Your apps" section
   - Look for Android apps (you might see multiple with different package names)

3. **Delete Each Android App**
   - Click the **⚙️ (gear/settings icon)** next to each Android app
   - Scroll down to the bottom of the app settings page
   - Click **"Delete app"** or **"Remove app"** button
   - Confirm deletion when prompted
   - Repeat for all Android apps

### Delete iOS App(s)

1. **Find iOS Apps**
   - In the same Firebase Console page, look for iOS apps

2. **Delete Each iOS App**
   - Click the **⚙️ (gear/settings icon)** next to each iOS app
   - Scroll down to the bottom of the app settings page
   - Click **"Delete app"** or **"Remove app"** button
   - Confirm deletion when prompted
   - Repeat for all iOS apps

**Note**: Keep the Web app - we don't need to delete that one.

---

## Step 2: Create New Android App

1. **Click "Add app" button**
   - You'll see this in the "Your apps" section

2. **Select Android**
   - Click the **Android** icon/button

3. **Enter App Details**
   - **Android package name**: `com.et3am.eqmsapp` ⚠️ **Exactly this!**
   - **App nickname** (optional): `eqmsapp-android` or leave blank
   - **Debug signing certificate SHA-1** (optional): Leave blank for now

4. **Register App**
   - Click **"Register app"** button

5. **Download Config File**
   - Click **"Download google-services.json"**
   - Save the file

6. **Replace Config File**
   - Copy the downloaded `google-services.json`
   - **Replace** the file at: `android/app/google-services.json`
   - Make sure to overwrite the old one!

7. **Skip Remaining Steps**
   - Click "Next" or "Continue to console" to skip optional steps

---

## Step 3: Create New iOS App

1. **Click "Add app" button again**
   - Still on the same Firebase Console page

2. **Select iOS**
   - Click the **iOS** icon/button

3. **Enter App Details**
   - **iOS bundle ID**: `com.et3am.eqmsapp` ⚠️ **Exactly this!**
   - **App nickname** (optional): `eqmsapp-ios` or leave blank

4. **Register App**
   - Click **"Register app"** button

5. **Download Config File**
   - Click **"Download GoogleService-Info.plist"**
   - Save the file

6. **Replace Config File**
   - Copy the downloaded `GoogleService-Info.plist`
   - **Replace** the file at: `ios/Runner/GoogleService-Info.plist`
   - Make sure to overwrite the old one!

7. **Skip Remaining Steps**
   - Click "Next" or "Continue to console" to skip optional steps

---

## Step 4: Verify Config Files

After replacing both config files, verify they have the correct IDs:

### Check Android Config
Open `android/app/google-services.json` and verify:
```json
"package_name": "com.et3am.eqmsapp"
```

### Check iOS Config
Open `ios/Runner/GoogleService-Info.plist` and verify:
```xml
<key>BUNDLE_ID</key>
<string>com.et3am.eqmsapp</string>
```

---

## Step 5: Re-run FlutterFire Configure

After you've deleted the old apps, created new ones, and replaced the config files, run:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs (`com.et3am.eqmsapp`)
- Update `firebase_options.dart` with the new app configs
- Link everything correctly

---

## Step 6: Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Quick Checklist

- [ ] Deleted all existing Android apps from Firebase Console
- [ ] Deleted all existing iOS apps from Firebase Console
- [ ] Created new Android app with package `com.et3am.eqmsapp`
- [ ] Downloaded new `google-services.json` and replaced `android/app/google-services.json`
- [ ] Created new iOS app with bundle ID `com.et3am.eqmsapp`
- [ ] Downloaded new `GoogleService-Info.plist` and replaced `ios/Runner/GoogleService-Info.plist`
- [ ] Verified both config files have correct IDs
- [ ] Ready to run `flutterfire configure`

---

## Important Notes

- **Deleting apps**: This will remove the apps from Firebase, but won't affect your Firestore data
- **Config files**: Make sure to replace the old config files with the new ones
- **Web app**: Keep the existing Web app - we don't need to recreate it
- **After deletion**: You'll need to wait a moment before creating new apps (usually instant)

---

**After you've deleted the old apps, created new ones, and replaced the config files, let me know and I'll help you run FlutterFire configure!**

