# Firebase Data Migration Guide

## Overview
This guide explains how to push your existing app data to Firebase Firestore.

## Option 1: Initialize with Sample Data

If you want to start with sample data for testing:

1. **Update `main.dart`**:
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseService.initialize();
  
  // Initialize with sample data (only run once)
  await FirebaseInit.initializeDatabase(seedSampleData: true);
  
  runApp(const MyApp());
}
```

2. **Run the app once** to create the sample data
3. **Remove or comment out** the initialization line after first run

## Option 2: Migrate Existing In-Memory Data

If you have existing data in your app that you want to migrate:

### Step 1: Create a Migration Screen

Create a temporary migration screen or add a button to your admin screen:

```dart
import 'package:flutter/material.dart';
import 'utils/firebase_migration.dart';
import 'main.dart'; // Your models

class MigrationScreen extends StatelessWidget {
  final List<DistributionArea> areas;
  final List<Queue> queues;
  final List<Beneficiary> beneficiaries;
  final List<Admin> admins;
  
  const MigrationScreen({
    required this.areas,
    required this.queues,
    required this.beneficiaries,
    required this.admins,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Migrate to Firebase')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await FirebaseMigration.migrateAllData(
                areas: areas,
                queues: queues,
                beneficiaries: beneficiaries,
                admins: admins,
                createdBy: 'migration', // or current admin ID
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Migration completed!')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Migration failed: $e')),
              );
            }
          },
          child: Text('Migrate All Data'),
        ),
      ),
    );
  }
}
```

### Step 2: Run Migration

1. Navigate to the migration screen
2. Click "Migrate All Data"
3. Wait for migration to complete
4. Verify data in Firebase Console

## Option 3: Manual Data Entry

You can also manually add data through:
1. Firebase Console web interface
2. Your app's UI (which will save to Firestore)
3. Import from JSON/CSV files

## Option 4: Import from JSON

If you have data in JSON format:

1. **Prepare JSON file** with your data
2. **Use Firebase Admin SDK** or **Firebase Console** to import
3. **Or create a script** to read JSON and use migration utilities

Example JSON structure:
```json
{
  "distributionAreas": [
    {
      "id": "area_1",
      "country": "Egypt",
      "governorate": "Cairo",
      "city": "Nasr City",
      "areaName": "Nasr City Queue Point"
    }
  ],
  "queues": [
    {
      "name": "Morning Meals Queue",
      "queueManager": "Admin User",
      "distributionArea": "area_1",
      // ... other fields
    }
  ]
}
```

## Verification

After migration, verify your data:

1. **Check Firebase Console**:
   - Go to Firestore Database
   - Verify all collections exist
   - Check document counts

2. **Use verification utility**:
```dart
await FirebaseInit.verifyStructure();
```

3. **Test queries**:
   - Try fetching data using service classes
   - Verify real-time updates work

## Important Notes

1. **Backup First**: Always backup your data before migration
2. **Test Environment**: Test migration in a development environment first
3. **Batch Limits**: Firestore batch writes are limited to 500 operations
4. **Indexes**: Create required indexes in Firebase Console
5. **Security Rules**: Update security rules before production
6. **Unique Constraints**: Ensure unique fields (ID numbers, mobile numbers) don't conflict

## Troubleshooting

### Migration Fails
- Check Firebase connection
- Verify data format matches schema
- Check Firestore quotas and limits
- Review error messages in console

### Data Not Appearing
- Refresh Firebase Console
- Check security rules allow writes
- Verify collection names match
- Check for errors in app logs

### Duplicate Data
- Check if data already exists before migrating
- Use `doc(id)` instead of `add()` to control document IDs
- Add checks to prevent duplicate entries

## Next Steps

After migration:
1. Update app to use Firestore streams instead of in-memory data
2. Remove hardcoded data from your app
3. Test all CRUD operations
4. Set up proper authentication
5. Configure security rules for production

