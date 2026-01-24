# 🔥 Update Firebase Apps - Step by Step Guide

## What You Need to Do

You need to update your Firebase apps to use the new package/bundle IDs:
- **Android**: `com.et3am.eqmsapp` (currently `com.example.eqmsapp`)
- **iOS**: `com.et3am.eqmsapp` (currently `com.example.eqmsapp`)

---

## Step-by-Step Instructions

### Step 1: Open Firebase Console

1. Go to: **https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general**
2. Sign in with your Google account if prompted

---

### Step 2: Update Android App

1. **Find the Android App**
   - Scroll down to the "Your apps" section
   - Look for the Android app (it should show package name `com.example.eqmsapp`)

2. **Add New Package Name**
   - Click the **⚙️ (gear/settings icon)** next to the Android app
   - This opens the app settings page
   - Scroll down to find **"Your apps"** section (shows all package names for this app)
   - Click **"Add another package name"** button
   - Enter: `com.et3am.eqmsapp`
   - Click **"Register app"** or **"Add"**

3. **Download New Config File**
   - After adding, you'll see the new package name listed
   - Click **"Download google-services.json"** (or find the download button)
   - Save the file
   - **Replace** the existing file at: `android/app/google-services.json`

---

### Step 3: Update iOS App

1. **Find the iOS App**
   - In the same Firebase Console page, find the iOS app
   - It should show bundle ID `com.example.eqmsapp`

2. **Add New Bundle ID**
   - Click the **⚙️ (gear/settings icon)** next to the iOS app
   - Scroll down to find **"Your apps"** section
   - Click **"Add another bundle ID"** button
   - Enter: `com.et3am.eqmsapp`
   - Click **"Register app"** or **"Add"**

3. **Download New Config File**
   - After adding, click **"Download GoogleService-Info.plist"**
   - Save the file
   - **Replace** the existing file at: `ios/Runner/GoogleService-Info.plist`
   - (If it's in `ios/Flutter/`, replace it there instead)

---

### Step 4: Alternative Method (If "Add another" doesn't work)

If you can't find the "Add another package name/bundle ID" option, create new apps:

#### Create New Android App:
1. On the Firebase Console page, click **"Add app"** button
2. Select **Android** icon
3. **Android package name**: `com.et3am.eqmsapp`
4. **App nickname** (optional): `eqmsapp-android`
5. Click **"Register app"**
6. Download `google-services.json` → Replace `android/app/google-services.json`

#### Create New iOS App:
1. Click **"Add app"** button again
2. Select **iOS** icon
3. **iOS bundle ID**: `com.et3am.eqmsapp`
4. **App nickname** (optional): `eqmsapp-ios`
5. Click **"Register app"**
6. Download `GoogleService-Info.plist` → Place in `ios/Runner/`

---

## Step 5: After Updating Firebase Console

Once you've updated the apps and downloaded the new config files:

### 1. Replace Config Files
- Replace `android/app/google-services.json` with the new one
- Replace `ios/Runner/GoogleService-Info.plist` with the new one

### 2. Re-run FlutterFire Configure

Run this command to update `firebase_options.dart`:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs (`com.et3am.eqmsapp`)
- Update `firebase_options.dart` automatically
- Link everything correctly

### 3. Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Quick Checklist

- [ ] Opened Firebase Console and signed in
- [ ] Added `com.et3am.eqmsapp` to Android app (or created new Android app)
- [ ] Downloaded new `google-services.json` and replaced old one
- [ ] Added `com.et3am.eqmsapp` to iOS app (or created new iOS app)
- [ ] Downloaded new `GoogleService-Info.plist` and replaced old one
- [ ] Ran `flutterfire configure --project=et3am-ca94c --platforms=android,ios,web`
- [ ] Ran `flutter clean && flutter pub get`
- [ ] Tested app with `flutter run`

---

## Need Help?

If you get stuck or need clarification on any step, let me know! After you update the Firebase Console, I can help you run the FlutterFire configure command.

---

**Important**: The old config files won't work with the new package names, so make sure to download and replace them after updating Firebase Console!

