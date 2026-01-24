# FlutterFire Configure - Complete Guide

## Prerequisites Checklist

Before running `flutterfire configure`, make sure:

- [x] Android app added to Firebase ✅
- [ ] iOS app added to Firebase (add now)
- [ ] Web app added to Firebase (add now)
- [x] `google-services.json` in `android/app/` ✅
- [x] Firebase CLI installed ✅
- [x] FlutterFire CLI installed ✅
- [ ] Logged into Firebase: `firebase login`

---

## Step 1: Login to Firebase (if not already)

```powershell
firebase login
```

This will open your browser to login with your Google account.

---

## Step 2: Add iOS App to Firebase

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
2. Click "Add app" → iOS
3. Bundle ID: `com.example.eqmsapp`
4. Click "Register app"
5. Download `GoogleService-Info.plist` (save it)

---

## Step 3: Add Web App to Firebase

1. In Firebase Console, click "Add app" → Web
2. App nickname: `EQMS Web`
3. Click "Register app"
4. Copy the config (optional - FlutterFire will handle it)

---

## Step 4: Run FlutterFire Configure

```powershell
# Navigate to project root
cd D:\XYZ\Docs\DevArea\eqmsapp

# Run configure
flutterfire configure
```

**Interactive prompts:**
1. **Select Firebase project**: Choose `et3am-ca94c`
2. **Select platforms**: It will show Android, iOS, Web - select all or press Enter for all
3. **Wait for completion** - It will download and place all files

---

## Step 5: Update Your Code

After `flutterfire configure` completes, update `lib/main.dart`:

### Uncomment the import:
```dart
import 'firebase_options.dart'; // Uncomment this line
```

### Update initialization:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform, // Use this
);
```

---

## Step 6: Test

```powershell
flutter clean
flutter pub get
flutter run
```

You should see:
```
✅ Firebase initialized successfully
```

---

## What Gets Created

After `flutterfire configure`:

- ✅ `lib/firebase_options.dart` - Platform-specific configs
- ✅ `ios/Runner/GoogleService-Info.plist` - iOS config (if iOS app added)
- ✅ `android/app/google-services.json` - Verified/updated
- ✅ Build files updated automatically

---

## If FlutterFire CLI Fails

### Alternative: Manual Configuration

If `flutterfire configure` doesn't work, you can:

1. **Place `GoogleService-Info.plist` manually**:
   - Open Xcode: `ios/Runner.xcworkspace`
   - Drag `GoogleService-Info.plist` into `Runner` folder

2. **Create `firebase_options.dart` manually** (or use the one FlutterFire would generate)

3. **Update `web/index.html`** with Firebase config

But try `flutterfire configure` first - it's much easier!

---

**Ready to add iOS and Web apps? Follow the steps above, then run `flutterfire configure`!** 🚀

