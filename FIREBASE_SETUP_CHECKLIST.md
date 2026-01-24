# Firebase Setup Checklist for et3am-ca94c

## ✅ Step-by-Step Checklist

### 1. Download Configuration Files

#### Android:
- [ ] Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
- [ ] Add Android app (if not exists)
- [ ] Package name: `com.example.eqmsapp`
- [ ] Download `google-services.json`
- [ ] Place in: `android/app/google-services.json` ✅

#### iOS (if needed):
- [ ] Add iOS app in Firebase Console
- [ ] Bundle ID: `com.example.eqmsapp`
- [ ] Download `GoogleService-Info.plist`
- [ ] Add to Xcode project ✅

---

### 2. Update Build Files

#### Android - Already Updated! ✅
- [x] `android/settings.gradle.kts` - Google Services plugin added
- [x] `android/app/build.gradle.kts` - Google Services plugin added

**You just need to:**
- [ ] Place `google-services.json` in `android/app/` folder

---

### 3. Enable Firebase Services

- [ ] **Firestore**: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore
  - Click "Create database" → Test mode → Enable
  
- [ ] **Authentication**: https://console.firebase.google.com/u/0/project/et3am-ca94c/authentication
  - Click "Get started" → Enable "Email/Password"
  
- [ ] **Storage**: https://console.firebase.google.com/u/0/project/et3am-ca94c/storage
  - Click "Get started" → Test mode → Enable

---

### 4. Test Connection

```bash
flutter clean
flutter pub get
flutter run
```

- [ ] App runs without errors
- [ ] Console shows: `✅ Firebase initialized successfully`
- [ ] No white screen

---

### 5. Create Collections (Optional)

- [ ] In `lib/main.dart`, change to `SetupScreen()`
- [ ] Run app and click "Setup Collections"
- [ ] Verify in Firebase Console: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore
- [ ] Change back to `LoginScreen()`

---

## 🎯 Quick Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get

# Run app
flutter run

# Check for errors
flutter doctor
```

---

## 📍 File Locations

```
Your Project/
├── android/
│   ├── app/
│   │   ├── google-services.json  ← PLACE HERE
│   │   └── build.gradle.kts      ← Already updated ✅
│   ├── build.gradle.kts          ← Already updated ✅
│   └── settings.gradle.kts       ← Already updated ✅
├── ios/
│   └── Runner/
│       └── GoogleService-Info.plist  ← For iOS
└── lib/
    └── main.dart
```

---

## ⚠️ Important Notes

1. **Package Name**: Must be exactly `com.example.eqmsapp` in Firebase Console
2. **File Location**: `google-services.json` MUST be in `android/app/` not `android/`
3. **Build Files**: Already updated - you don't need to change them
4. **Firebase Services**: Must be enabled before app can connect

---

## 🆘 If Something Goes Wrong

1. **Check console errors** - Look for Firebase-related messages
2. **Verify file locations** - `google-services.json` in correct folder
3. **Check package name** - Must match exactly
4. **Run `flutter clean`** - Clears cached build files
5. **Check Firebase Console** - Verify services are enabled

---

## 📚 Documentation

- **Quick Setup**: `QUICK_FIREBASE_SETUP.md`
- **Detailed Steps**: `FIREBASE_CONFIGURATION_STEPS.md`
- **Database Structure**: `FIRESTORE_DATABASE_STRUCTURE.md`

---

**You're almost done!** Just download `google-services.json` and place it in the correct folder! 🚀

