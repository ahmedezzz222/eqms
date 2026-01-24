# 🔧 Fix iOS Bundle ID

## Current Status

✅ **Android**: Correct - `com.et3am.eqmsapp`  
❌ **iOS**: Wrong - `com.et3amapp.eqmsapp` (should be `com.et3am.eqmsapp`)

---

## Solution: Create New iOS App in Firebase

Since the iOS bundle ID is incorrect, you need to create a new iOS app with the correct bundle ID.

### Step 1: Create New iOS App in Firebase Console

1. **Go to Firebase Console**
   - https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general

2. **Click "Add app" button**
   - Look for the "+" or "Add app" button in the "Your apps" section

3. **Select iOS**
   - Click the **iOS** icon/button

4. **Enter App Details**
   - **iOS bundle ID**: `com.et3am.eqmsapp` ⚠️ **Make sure it's exactly this!**
   - **App nickname** (optional): `eqmsapp-ios` or leave blank

5. **Register App**
   - Click **"Register app"** button

6. **Download Config File**
   - Click **"Download GoogleService-Info.plist"**
   - Save the file

7. **Replace Config File**
   - Copy the downloaded `GoogleService-Info.plist`
   - **Replace** the file at: `ios/Runner/GoogleService-Info.plist`
   - Make sure to overwrite the old one!

8. **Verify Bundle ID**
   - After replacing, the file should have:
     ```xml
     <key>BUNDLE_ID</key>
     <string>com.et3am.eqmsapp</string>
     ```
   - (Not `com.et3amapp.eqmsapp`)

---

## Step 2: After Replacing iOS Config

Once you've downloaded and replaced the `GoogleService-Info.plist` file:

### Re-run FlutterFire Configure

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the correct bundle ID (`com.et3am.eqmsapp`)
- Update `firebase_options.dart` with the new iOS config
- Link everything correctly

### Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Quick Checklist

- [ ] Created new iOS app in Firebase Console with bundle ID `com.et3am.eqmsapp`
- [ ] Downloaded new `GoogleService-Info.plist`
- [ ] Replaced `ios/Runner/GoogleService-Info.plist` with the new file
- [ ] Verified the BUNDLE_ID in the plist file is `com.et3am.eqmsapp`
- [ ] Ready to run `flutterfire configure`

---

**After you create the new iOS app and replace the config file, let me know and I'll help you run FlutterFire configure!**

