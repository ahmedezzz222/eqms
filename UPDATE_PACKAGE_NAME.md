# Update Package Name to com.et3am.eqmsapp

## Changes Made

### ✅ Android
- Updated `namespace` in `android/app/build.gradle.kts`
- Updated `applicationId` in `android/app/build.gradle.kts`

### ✅ iOS
- Updated `PRODUCT_BUNDLE_IDENTIFIER` in `ios/Runner.xcodeproj/project.pbxproj`

---

## Next Steps

### Step 1: Update Firebase Apps

You need to update the apps in Firebase Console with the new package/bundle IDs:

#### For Android:
1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
2. Find your Android app
3. Click the settings icon (⚙️) next to it
4. Click "Add another package name"
5. Enter: `com.et3am.eqmsapp`
6. Download the new `google-services.json`
7. Replace `android/app/google-services.json` with the new file

**OR** create a new Android app with package name `com.et3am.eqmsapp`

#### For iOS:
1. In Firebase Console, find your iOS app
2. Click the settings icon (⚙️) next to it
3. Click "Add another bundle ID"
4. Enter: `com.et3am.eqmsapp`
5. Download the new `GoogleService-Info.plist`
6. Replace the existing one

**OR** create a new iOS app with bundle ID `com.et3am.eqmsapp`

---

### Step 2: Re-run FlutterFire Configure

After updating Firebase apps, run:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs
- Update `firebase_options.dart` with new configs
- Update configuration files

---

### Step 3: Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## Alternative: Create New Apps in Firebase

If you prefer to create fresh apps:

1. **Android**: Add new app with package: `com.et3am.eqmsapp`
2. **iOS**: Add new app with bundle ID: `com.et3am.eqmsapp`
3. **Web**: Keep existing or create new
4. Run `flutterfire configure` to link them

---

## Important Notes

- The old `google-services.json` won't work with the new package name
- You must update Firebase Console apps or create new ones
- After updating, re-run `flutterfire configure`
- The `firebase_options.dart` will be regenerated with new configs

---

**After updating Firebase Console apps, let me know and I'll help you re-run FlutterFire configure!**

