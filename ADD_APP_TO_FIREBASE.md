# Add Flutter App to Firebase Console

## Your Firebase Project
**Project**: `et3am-ca94c`  
**Console**: https://console.firebase.google.com/u/0/project/et3am-ca94c

---

## Step 1: Add Android App

1. **Go to Firebase Console**:
   - https://console.firebase.google.com/u/0/project/et3am-ca94c/settings/general
   - Scroll down to "Your apps" section

2. **Click "Add app" → Android** (or Android icon)

3. **Enter App Information**:
   - **Android package name**: `com.example.eqmsapp`
     - (This is from your `android/app/build.gradle.kts` file)
   - **App nickname (optional)**: `EQMS Android`
   - **Debug signing certificate SHA-1**: (Leave blank for now, can add later)

4. **Click "Register app"**

5. **Download `google-services.json`**:
   - Click "Download google-services.json"
   - **Save this file** - we'll place it later

---

## Step 2: Add iOS App

1. **In Firebase Console**, click "Add app" → iOS

2. **Enter App Information**:
   - **iOS bundle ID**: `com.example.eqmsapp`
     - (Check your `ios/Runner.xcodeproj` or `ios/Runner/Info.plist` for actual bundle ID)
   - **App nickname (optional)**: `EQMS iOS`

3. **Click "Register app"**

4. **Download `GoogleService-Info.plist`**:
   - Click "Download GoogleService-Info.plist"
   - **Save this file** - we'll place it later

---

## Step 3: Add Web App

1. **In Firebase Console**, click "Add app" → Web (</> icon)

2. **Enter App Information**:
   - **App nickname**: `EQMS Web`
   - **Firebase Hosting** (optional): Leave unchecked for now

3. **Click "Register app"**

4. **Copy the Firebase Config**:
   - You'll see a config object like this:
   ```javascript
   const firebaseConfig = {
     apiKey: "YOUR_API_KEY",
     authDomain: "et3am-ca94c.firebaseapp.com",
     projectId: "et3am-ca94c",
     storageBucket: "et3am-ca94c.appspot.com",
     messagingSenderId: "YOUR_SENDER_ID",
     appId: "YOUR_APP_ID"
   };
   ```
   - **Save this config** - we'll use it for web

---

## Step 4: After Adding Apps

Once you've added all three apps (Android, iOS, Web) to Firebase Console, you have two options:

### Option A: Use FlutterFire CLI (Recommended)

After adding apps to Firebase Console, run:

```powershell
# Make sure you're in project root
cd D:\XYZ\Docs\DevArea\eqmsapp

# Configure (this will detect the apps you just added)
flutterfire configure
```

FlutterFire CLI will:
- Detect your Firebase project
- Find the apps you just added
- Download configuration files automatically
- Create `lib/firebase_options.dart`

### Option B: Manual Configuration

If FlutterFire CLI doesn't work, you can manually place the files:

1. **Place `google-services.json`**:
   - Copy to: `android/app/google-services.json`

2. **Place `GoogleService-Info.plist`**:
   - Open Xcode: `ios/Runner.xcworkspace`
   - Drag file into `Runner` folder

3. **Update `web/index.html`**:
   - Add Firebase SDK scripts and config

---

## What Information I Need From You

After you add the apps, please provide:

1. **Android Package Name** (if different from `com.example.eqmsapp`)
   - Check: `android/app/build.gradle.kts` → `applicationId`

2. **iOS Bundle ID** (if different)
   - Check: `ios/Runner/Info.plist` → `CFBundleIdentifier`

3. **Confirmation** that all three apps are added in Firebase Console

---

## Quick Checklist

- [ ] Android app added to Firebase Console
- [ ] iOS app added to Firebase Console  
- [ ] Web app added to Firebase Console
- [ ] All apps registered successfully
- [ ] Ready to run `flutterfire configure`

---

## After Adding Apps

Once you've added all apps, run:

```powershell
cd D:\XYZ\Docs\DevArea\eqmsapp
flutterfire configure
```

Select your project: **et3am-ca94c**

FlutterFire will automatically:
- ✅ Detect all three apps
- ✅ Download configuration files
- ✅ Set up everything for you!

---

**Let me know when you've added the apps, and I'll help you complete the configuration!** 🚀

