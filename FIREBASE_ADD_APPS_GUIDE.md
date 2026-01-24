# Add Your Flutter App to Firebase - Exact Steps

## Your App Information

- **Android Package Name**: `com.example.eqmsapp`
- **iOS Bundle ID**: `com.example.eqmsapp`
- **Firebase Project**: `et3am-ca94c`

---

## Step-by-Step Instructions

### 1. Add Android App

1. **Go to**: https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
2. **Scroll down** to "Your apps" section
3. **Click the Android icon** (or "Add app" → Android)
4. **Enter**:
   - **Android package name**: `com.example.eqmsapp` ⬅️ **Copy this exactly**
   - **App nickname (optional)**: `EQMS Android`
   - **Debug signing certificate SHA-1**: (Leave blank for now)
5. **Click "Register app"**
6. **Download `google-services.json`** (save it somewhere, we'll place it later)
7. **Click "Next"** through the remaining steps (you can skip them for now)

---

### 2. Add iOS App

1. **Still in Firebase Console**, click **"Add app"** → **iOS** (Apple icon)
2. **Enter**:
   - **iOS bundle ID**: `com.example.eqmsapp` ⬅️ **Copy this exactly**
   - **App nickname (optional)**: `EQMS iOS`
3. **Click "Register app"**
4. **Download `GoogleService-Info.plist`** (save it somewhere, we'll place it later)
5. **Click "Next"** through the remaining steps

---

### 3. Add Web App

1. **Still in Firebase Console**, click **"Add app"** → **Web** (</> icon)
2. **Enter**:
   - **App nickname**: `EQMS Web`
   - **Firebase Hosting**: (Leave unchecked)
3. **Click "Register app"**
4. **Copy the Firebase config** - you'll see something like:
   ```javascript
   const firebaseConfig = {
     apiKey: "AIza...",
     authDomain: "et3am-ca94c.firebaseapp.com",
     projectId: "et3am-ca94c",
     storageBucket: "et3am-ca94c.appspot.com",
     messagingSenderId: "123456789",
     appId: "1:123456789:web:abc123"
   };
   ```
   - **Save this config** (we'll use it later)

---

## After Adding All Apps

Once you've added all three apps (Android, iOS, Web), you have two options:

### Option A: Use FlutterFire CLI (Easiest)

Run this command from your project root:

```powershell
cd D:\XYZ\Docs\DevArea\eqmsapp
flutterfire configure
```

**What will happen:**
1. It will show your Firebase projects
2. Select: **et3am-ca94c**
3. It will detect the apps you just added
4. Automatically download and place configuration files
5. Create `lib/firebase_options.dart`

### Option B: Manual Placement

If FlutterFire CLI doesn't work, manually place the files:

1. **`google-services.json`** → `android/app/google-services.json`
2. **`GoogleService-Info.plist`** → `ios/Runner/GoogleService-Info.plist` (via Xcode)
3. **Web config** → Update `web/index.html`

---

## Quick Reference

**Firebase Console**: https://console.firebase.google.com/u/0/project/et3am-ca94c

**Your Values**:
- Android Package: `com.example.eqmsapp`
- iOS Bundle ID: `com.example.eqmsapp`
- Project ID: `et3am-ca94c`

---

## What to Do After Adding Apps

1. ✅ Add Android app with package: `com.example.eqmsapp`
2. ✅ Add iOS app with bundle ID: `com.example.eqmsapp`
3. ✅ Add Web app
4. ✅ Run `flutterfire configure` from project root
5. ✅ Select project `et3am-ca94c`
6. ✅ Let FlutterFire configure everything automatically!

---

**After you add the apps, let me know and I'll help you run `flutterfire configure`!** 🚀

