# FlutterFire CLI - Quick Start Guide

## 🚀 Quick Setup (5 Minutes)

### Step 1: Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

**Windows**: Make sure `%LOCALAPPDATA%\Pub\Cache\bin` is in your PATH, or use:
```bash
flutter pub global run flutterfire_cli:configure
```

### Step 2: Login to Firebase

```bash
firebase login
```

This will open a browser for you to login with your Google account.

### Step 3: Configure Your App

```bash
flutterfire configure
```

**What it does:**
1. Lists your Firebase projects
2. Select: **et3am-ca94c**
3. Detects your platforms (Android, iOS, Web)
4. Downloads configuration files automatically
5. Creates `lib/firebase_options.dart`

### Step 4: Install Dependencies

```bash
flutter pub get
```

### Step 5: Run Your App

```bash
flutter run
```

---

## ✅ What Gets Created

After running `flutterfire configure`:

- ✅ `android/app/google-services.json` - Android config
- ✅ `ios/Runner/GoogleService-Info.plist` - iOS config  
- ✅ `lib/firebase_options.dart` - Web config + platform detection
- ✅ Build files updated automatically

---

## 📝 Your main.dart is Already Updated!

I've already updated your `main.dart` to use:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

This automatically detects the platform and uses the correct config!

---

## 🔧 Troubleshooting

### "flutterfire: command not found"

**Windows:**
```bash
# Add to PATH or use:
flutter pub global run flutterfire_cli:configure
```

**Mac/Linux:**
```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### "firebase: command not found"

Install Firebase CLI:
```bash
npm install -g firebase-tools
```

### "No Firebase projects found"

Make sure you're logged in:
```bash
firebase login
```

### "firebase_options.dart not found"

Run:
```bash
flutterfire configure
```

This will create the file.

---

## 🎯 Next Steps

1. ✅ Run `flutterfire configure`
2. ✅ Enable Firestore, Auth, Storage in Firebase Console
3. ✅ Run `flutter pub get`
4. ✅ Test your app: `flutter run`
5. ✅ Use Setup Screen to create collections

---

## 📚 Full Documentation

- **Detailed Guide**: `FLUTTERFIRE_CLI_SETUP.md`
- **Firebase Console**: https://console.firebase.google.com/u/0/project/et3am-ca94c

---

**That's it!** FlutterFire CLI handles everything automatically! 🎉

