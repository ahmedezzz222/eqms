# Update Package Name to com.et3am.eqmsapp

## ✅ Changes Made in Code

### Android
- ✅ Updated `namespace` in `android/app/build.gradle.kts` → `com.et3am.eqmsapp`
- ✅ Updated `applicationId` in `android/app/build.gradle.kts` → `com.et3am.eqmsapp`

### iOS
- ✅ Updated `PRODUCT_BUNDLE_IDENTIFIER` in `ios/Runner.xcodeproj/project.pbxproj` → `com.et3am.eqmsapp`
- ✅ Updated test bundle identifiers → `com.et3am.eqmsapp.RunnerTests`

---

## 🔄 Next Steps: Update Firebase Apps

You need to update your Firebase apps to use the new package/bundle IDs. You have two options:

### Option 1: Add New Package/Bundle ID to Existing Apps (Recommended)

#### For Android:
1. Go to Firebase Console: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
2. Find your Android app (the one with package `com.example.eqmsapp`)
3. Click the ⚙️ (settings) icon next to it
4. Scroll down to "Your apps" section
5. Click "Add another package name"
6. Enter: `com.et3am.eqmsapp`
7. Click "Register app"
8. Download the new `google-services.json`
9. Replace `android/app/google-services.json` with the new file

#### For iOS:
1. In Firebase Console, find your iOS app (the one with bundle ID `com.example.eqmsapp`)
2. Click the ⚙️ (settings) icon next to it
3. Scroll down to "Your apps" section
4. Click "Add another bundle ID"
5. Enter: `com.et3am.eqmsapp`
6. Click "Register app"
7. Download the new `GoogleService-Info.plist`
8. Replace the existing one in `ios/Runner/` (or `ios/Flutter/`)

---

### Option 2: Create New Apps (Alternative)

If you prefer to create fresh apps:

1. **Android**: 
   - Go to Firebase Console → Project Settings → Your apps
   - Click "Add app" → Android
   - Package name: `com.et3am.eqmsapp`
   - Download `google-services.json` → Replace in `android/app/`

2. **iOS**:
   - Click "Add app" → iOS
   - Bundle ID: `com.et3am.eqmsapp`
   - Download `GoogleService-Info.plist` → Place in `ios/Runner/`

3. **Web**: Keep existing or create new

---

## 🔧 Step 2: Re-run FlutterFire Configure

After updating Firebase apps, run:

```powershell
flutterfire configure --project=et3am-ca94c --platforms=android,ios,web
```

This will:
- Detect the new package/bundle IDs (`com.et3am.eqmsapp`)
- Update `firebase_options.dart` with new configs
- Link the correct Firebase apps

---

## 🧹 Step 3: Clean and Rebuild

```powershell
flutter clean
flutter pub get
flutter run
```

---

## ⚠️ Important Notes

- The old `google-services.json` won't work with the new package name
- You **must** update Firebase Console apps or create new ones
- After updating, **re-run `flutterfire configure`** to update `firebase_options.dart`
- The `iosBundleId` in `firebase_options.dart` will be updated automatically

---

## 📋 Quick Checklist

- [ ] Updated Android package name in Firebase Console
- [ ] Downloaded new `google-services.json` and replaced old one
- [ ] Updated iOS bundle ID in Firebase Console
- [ ] Downloaded new `GoogleService-Info.plist` and replaced old one
- [ ] Ran `flutterfire configure --project=et3am-ca94c --platforms=android,ios,web`
- [ ] Ran `flutter clean && flutter pub get`
- [ ] Tested app with `flutter run`

---

**After you update the Firebase apps, let me know and I can help you re-run FlutterFire configure!**

