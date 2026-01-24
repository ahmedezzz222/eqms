# Quick Setup Instructions - Firebase Collections

## Your Firebase Project
**Project ID**: `et3am-ca94c`  
**Console URL**: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore/databases/-default-/data

## Method 1: Using Setup Screen (Easiest)

### Step 1: Enable Setup Screen

In `lib/main.dart`, temporarily change:

```dart
home: const LoginScreen(), // Change to SetupScreen() for one-time setup
```

To:

```dart
home: const SetupScreen(), // Run setup once
```

### Step 2: Run the App

1. Run your Flutter app
2. You'll see the Setup Screen
3. Click "Setup Collections" button
4. Wait for setup to complete (you'll see ✅ checkmarks)
5. (Optional) Click "Remove Sample Documents" to clean up

### Step 3: Switch Back

Change back to:

```dart
home: const LoginScreen(),
```

## Method 2: Add Setup Button to Admin Screen

Add this button to your admin/settings screen:

```dart
import 'utils/one_time_setup.dart';

ElevatedButton(
  onPressed: () async {
    final results = await OneTimeSetup.setupCollections();
    if (results['collections'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Collections created!')),
      );
    }
  },
  child: Text('Setup Firebase Collections'),
)
```

## Method 3: Run from main.dart (One-time)

Add this to `main.dart` after Firebase initialization:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.initialize();
  
  // Run this ONCE to setup collections
  // await OneTimeSetup.setupCollections();
  // Then comment it out after first run
  
  runApp(const MyApp());
}
```

## What Gets Created

The setup will create these 8 collections in your Firebase project:

1. ✅ `distributionAreas` - Queue Points
2. ✅ `queues` - Queue management  
3. ✅ `beneficiaries` - Beneficiary records
4. ✅ `admins` - Admin accounts
5. ✅ `volunteers` - Volunteer accounts
6. ✅ `entities` - Entity names
7. ✅ `queueHistory` - Queue operation history
8. ✅ `reports` - Generated reports

Each collection will have one sample document to initialize it.

## Verify in Firebase Console

1. Go to: https://console.firebase.google.com/u/0/project/et3am-ca94c/firestore/databases/-default-/data
2. You should see all 8 collections listed
3. Click on each collection to verify structure
4. Delete sample documents if desired

## Next Steps

After setup:
1. ✅ Collections are ready
2. ✅ Set up Security Rules (see FIRESTORE_DATABASE_STRUCTURE.md)
3. ✅ Create Indexes (Firebase will prompt you)
4. ✅ Start using your app - data will save to Firestore automatically

## Troubleshooting

**Error: "Permission denied"**
- Check that Firestore is enabled in your project
- Verify you're logged into the correct Firebase account

**Collections not appearing**
- Refresh Firebase Console
- Check app logs for errors
- Verify Firebase initialization in main.dart

**Sample documents still there**
- Use "Remove Sample Documents" button
- Or delete manually from Firebase Console

## Security Rules Setup

After collections are created, update security rules:

1. Go to Firestore → Rules
2. Copy rules from `FIRESTORE_DATABASE_STRUCTURE.md`
3. Paste and Publish

## Indexes Setup

Firebase will automatically prompt you to create indexes when needed, or:

1. Go to Firestore → Indexes
2. Create indexes as listed in `FIRESTORE_DATABASE_STRUCTURE.md`

---

**Ready to go!** Your Firebase database structure is now set up. 🚀

