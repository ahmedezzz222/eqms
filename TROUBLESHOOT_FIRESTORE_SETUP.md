# 🔧 Troubleshooting Firestore Collections Setup

## Issue: Collections Not Created

If collections are not being created, check the following:

### 1. Enable Firestore Database

1. Go to Firebase Console: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore
2. If you see "Get started" or "Create database", click it
3. Choose **"Start in test mode"** (for development)
4. Select a location (choose closest to your users)
5. Click **"Enable"**

### 2. Check Firestore Rules

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore/rules
2. Make sure rules allow writes (for testing):
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if true; // For testing only!
       }
     }
   }
   ```
3. Click **"Publish"**

### 3. Check Console Output

When running the app, look for these messages:

**Success:**
```
✅ Firebase initialized successfully
🚀 Starting Firestore collections setup...
✅ Firestore connection verified
Setting up distributionAreas collection...
  ✅ Created sample distribution area
...
✅ All collections setup complete!
```

**Error:**
```
❌ Error setting up collections: [error message]
```

### 4. Common Errors

#### Error: "Missing or insufficient permissions"
- **Solution**: Update Firestore rules (see step 2)

#### Error: "Firestore is not enabled"
- **Solution**: Enable Firestore in Firebase Console (see step 1)

#### Error: "Network error"
- **Solution**: Check internet connection
- **Solution**: Check Firebase project is active

### 5. Manual Verification

After running the app, check Firebase Console:

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore/data
2. You should see 8 collections:
   - `distributionAreas`
   - `queues`
   - `beneficiaries`
   - `admins`
   - `volunteers`
   - `entities`
   - `queueHistory`
   - `reports`

### 6. Test Firestore Connection

Run this test in your app console:

```dart
// Test Firestore connection
try {
  await FirebaseFirestore.instance
      .collection('test')
      .doc('test')
      .set({'test': true});
  print('✅ Firestore write successful');
} catch (e) {
  print('❌ Firestore error: $e');
}
```

---

## Quick Fix Steps

1. ✅ **Enable Firestore** in Firebase Console
2. ✅ **Set Firestore rules** to allow writes (test mode)
3. ✅ **Run the app** and check console output
4. ✅ **Verify collections** in Firebase Console

---

## Still Not Working?

1. Check the app console for specific error messages
2. Verify Firebase project ID is correct: `et3am-ca94c`
3. Make sure you're signed in to the correct Firebase account
4. Try running the app again after enabling Firestore

---

**After enabling Firestore and updating rules, run the app again!**

