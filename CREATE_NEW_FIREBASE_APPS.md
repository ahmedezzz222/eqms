# 🔥 Create New Firebase Apps with com.et3am.eqmsapp

Since "Add another package name" option is not available, we'll create **new apps** with the new package/bundle IDs.

---

## Step 1: Open Firebase Console

1. Go to: **https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general**
2. Sign in if needed

---

## Step 2: Create New Android App

1. **Click "Add app" button**
   - You'll see this button at the top of the "Your apps" section
   - It might show as a "+" icon or "Add app" text

2. **Select Android**
   - Click the **Android** icon/button

3. **Enter App Details**
   - **Android package name**: `com.et3am.eqmsapp`
   - **App nickname** (optional): `eqmsapp-android` or leave blank
   - **Debug signing certificate SHA-1** (optional): Leave blank for now

4. **Register App**
   - Click **"Register app"** button

5. **Download Config File**
   - You'll see a download button for `google-services.json`
   - Click **"Download google-services.json"**
   - Save the file

6. **Replace Config File**
   - Copy the downloaded `google-services.json`
   - Replace the file at: `android/app/google-services.json`

7. **Click "Next"**
   - You can skip the remaining steps (they're optional)
   - Click "Continue to console" or "Next" until you're back to the settings page

---

## Step 3: Create New iOS App

1. **Click "Add app" button again**
   - Still on the same Firebase Console page

2. **Select iOS**
   - Click the **iOS** icon/button

3. **Enter App Details**
   - **iOS bundle ID**: `com.et3am.eqmsapp`
   - **App nickname** (optional): `eqmsapp-ios` or leave blank

4. **Register App**
   - Click **"Register app"** button

5. **Download Config File**
   - You'll see a download button for `GoogleService-Info.plist`
   - Click **"Download GoogleService-Info.plist"**
   - Save the file

6. **Replace Config File**
   - Copy the downloaded `GoogleService-Info.plist`
   - Replace the file at: `ios/Runner/GoogleService-Info.plist`
   - (If it's in `ios/Flutter/`, replace it there instead)

7. **Click "Next"**
   - Skip optional steps
   - Click "Continue to console"

---

## Step 4: After Creating Apps

Once you've created both new apps and downloaded the config files:

### 1. Verify Config Files Are Replaced
- ✅ `android/app/google-services.json` - Should be the new one
- ✅ `ios/Runner/GoogleService-Info.plist` - Should be the new one

### 2. Re-run FlutterFire Configure

Run this command to update `firebase_options.dart`:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs (`com.et3am.eqmsapp`)
- Update `firebase_options.dart` with the new app configs
- Link everything correctly

### 3. Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## What You'll See in Firebase Console

After creating the new apps, you should see:
- **Android app**: `com.et3am.eqmsapp` (new)
- **iOS app**: `com.et3am.eqmsapp` (new)
- **Web app**: `eqmsapp (web)` (existing, keep this)

You can keep the old apps (`com.example.eqmsapp`) or delete them later if you want.

---

## Quick Checklist

- [ ] Created new Android app with package `com.et3am.eqmsapp`
- [ ] Downloaded new `google-services.json` and replaced `android/app/google-services.json`
- [ ] Created new iOS app with bundle ID `com.et3am.eqmsapp`
- [ ] Downloaded new `GoogleService-Info.plist` and replaced `ios/Runner/GoogleService-Info.plist`
- [ ] Ready to run `flutterfire configure`

---

**After you create the new apps and replace the config files, let me know and I'll help you run FlutterFire configure!**

