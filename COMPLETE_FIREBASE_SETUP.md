# ✅ Complete Firebase Apps Setup Guide

## Overview

We need to:
1. Delete existing Android/iOS apps (if any)
2. Create new Android app: `com.et3am.eqmsapp`
3. Create new iOS app: `com.et3am.eqmsapp`
4. Download config files
5. Update project and run FlutterFire configure

---

## Step-by-Step Instructions

### Step 1: Open Firebase Console

1. Go to: **https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general**
2. **Sign in** with your Google account if prompted

---

### Step 2: Delete Existing Apps

#### Delete Android Apps:
1. Scroll to **"Your apps"** section
2. Find all **Android** apps
3. For each Android app:
   - Click the **⚙️ (gear icon)** next to it
   - Scroll to the **bottom** of the settings page
   - Click **"Delete app"** or **"Remove app"**
   - Confirm deletion

#### Delete iOS Apps:
1. Find all **iOS** apps
2. For each iOS app:
   - Click the **⚙️ (gear icon)** next to it
   - Scroll to the **bottom** of the settings page
   - Click **"Delete app"** or **"Remove app"**
   - Confirm deletion

**Note**: Keep the **Web** app - we don't need to delete it.

---

### Step 3: Create New Android App

1. Click **"Add app"** button (or **"+"** icon) in the "Your apps" section
2. Click the **Android** icon/button
3. Fill in:
   - **Android package name**: `com.et3am.eqmsapp` ⚠️ **Exactly this!**
   - **App nickname** (optional): `eqmsapp-android`
   - **Debug signing certificate SHA-1**: Leave blank
4. Click **"Register app"**
5. Click **"Download google-services.json"**
6. **Save the file** - you'll replace the old one
7. Click **"Next"** to skip remaining steps

---

### Step 4: Create New iOS App

1. Click **"Add app"** button again
2. Click the **iOS** icon/button
3. Fill in:
   - **iOS bundle ID**: `com.et3am.eqmsapp` ⚠️ **Exactly this!**
   - **App nickname** (optional): `eqmsapp-ios`
4. Click **"Register app"**
5. Click **"Download GoogleService-Info.plist"**
6. **Save the file** - you'll replace the old one
7. Click **"Next"** to skip remaining steps

---

### Step 5: Replace Config Files

#### Replace Android Config:
1. Copy the downloaded `google-services.json`
2. **Replace** the file at: `android/app/google-services.json`
3. Make sure to **overwrite** the old file

#### Replace iOS Config:
1. Copy the downloaded `GoogleService-Info.plist`
2. **Replace** the file at: `ios/Runner/GoogleService-Info.plist`
3. Make sure to **overwrite** the old file

---

### Step 6: Verify Config Files

#### Check Android (`android/app/google-services.json`):
Should contain:
```json
"package_name": "com.et3am.eqmsapp"
```

#### Check iOS (`ios/Runner/GoogleService-Info.plist`):
Should contain:
```xml
<key>BUNDLE_ID</key>
<string>com.et3am.eqmsapp</string>
```

---

### Step 7: Run FlutterFire Configure

After replacing both config files, run this command:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs
- Update `firebase_options.dart` automatically
- Link everything correctly

---

### Step 8: Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Quick Checklist

- [ ] Signed in to Firebase Console
- [ ] Deleted all existing Android apps
- [ ] Deleted all existing iOS apps
- [ ] Created new Android app with package `com.et3am.eqmsapp`
- [ ] Downloaded `google-services.json`
- [ ] Replaced `android/app/google-services.json`
- [ ] Created new iOS app with bundle ID `com.et3am.eqmsapp`
- [ ] Downloaded `GoogleService-Info.plist`
- [ ] Replaced `ios/Runner/GoogleService-Info.plist`
- [ ] Verified both config files have correct IDs
- [ ] Ran `flutterfire configure --project=et3am-ca94c --platforms=android,ios,web`
- [ ] Ran `flutter clean && flutter pub get`
- [ ] Tested with `flutter run`

---

## After You Complete These Steps

Once you've:
1. Created the new apps in Firebase Console
2. Downloaded and replaced the config files

**Let me know** and I'll help you:
- Run FlutterFire configure
- Verify everything is correct
- Test the setup

---

**The detailed steps are above. Once you've created the apps and replaced the config files, I can help with the FlutterFire configuration!**

