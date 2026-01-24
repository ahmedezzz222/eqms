# Manual Firebase Collections Setup Guide

## Option 1: Using the Setup Script (Recommended)

### Step 1: Add the Setup Function to Your App

In your `main.dart` or a setup screen, add:

```dart
import 'scripts/setup_firebase_collections.dart';

// In a button or initialization:
await FirebaseCollectionsSetup.setupAllCollections();
```

### Step 2: Run the App

1. Run your Flutter app
2. Trigger the setup function (button click or automatic)
3. Check Firebase Console to verify collections are created
4. (Optional) Run `cleanupSampleData()` to remove sample documents

## Option 2: Manual Setup via Firebase Console

### Step 1: Access Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on "Firestore Database" in the left menu

### Step 2: Create Collections

Collections are created automatically when you add the first document. Here's how to create each collection:

#### 1. distributionAreas Collection

1. Click "Start collection"
2. Collection ID: `distributionAreas`
3. Document ID: `sample_area` (or auto-generate)
4. Add fields:
   ```
   country (string): "Egypt"
   governorate (string): "Cairo"
   city (string): "Sample City"
   areaName (string): "Sample Queue Point"
   createdAt (timestamp): [Current time]
   updatedAt (timestamp): [Current time]
   ```
5. Click "Save"

#### 2. queues Collection

1. Click "Start collection"
2. Collection ID: `queues`
3. Document ID: `sample_queue` (or auto-generate)
4. Add fields:
   ```
   name (string): "Sample Queue"
   queueManager (string): "Admin"
   country (string): "Egypt"
   governorate (string): "Cairo"
   city (string): "Sample City"
   queuePointName (string): "Sample Queue Point"
   distributionArea (string): "sample_area"
   queueType (string): "Single Day"
   fromDate (timestamp): [Current time]
   toDate (timestamp): [Current time]
   fromTime (map): {hour: 8, minute: 0}
   toTime (map): {hour: 18, minute: 0}
   unitName (string): "Meals"
   numberOfAvailableUnits (number): 100
   estimatedQueueSize (number): 80
   directServe (boolean): false
   priority (array): []
   status (string): "active"
   isStarted (boolean): false
   isCompleted (boolean): false
   isSuspended (boolean): false
   createdAt (timestamp): [Current time]
   updatedAt (timestamp): [Current time]
   createdBy (string): "system"
   ```
5. Click "Save"

#### 3. beneficiaries Collection

1. Click "Start collection"
2. Collection ID: `beneficiaries`
3. Document ID: `sample_beneficiary` (or auto-generate)
4. Add fields:
   ```
   distributionArea (string): "sample_area"
   initialAssignedQueuePoint (string): "Sample Queue"
   type (string): "Normal"
   gender (string): "Male"
   name (string): "Sample Beneficiary"
   idNumber (string): "12345678901"
   isEntity (boolean): false
   numberOfUnits (string): "1"
   status (string): "Active"
   isServed (boolean): false
   unitsTaken (number): 0
   createdAt (timestamp): [Current time]
   updatedAt (timestamp): [Current time]
   createdBy (string): "system"
   ```
5. Click "Save"

#### 4. admins Collection

1. Click "Start collection"
2. Collection ID: `admins`
3. Document ID: `sample_admin` (or auto-generate)
4. Add fields:
   ```
   country (string): "Egypt"
   governorate (string): "Cairo"
   city (string): "Sample City"
   distributionPoint (string): "Sample Point"
   fullName (string): "Sample Admin"
   mobile (string): "01000000000"
   password (string): "password"
   notes (string): "Sample admin account"
   status (string): "active"
   isRequestedByGuest (boolean): false
   createdAt (timestamp): [Current time]
   updatedAt (timestamp): [Current time]
   ```
5. Click "Save"

#### 5. volunteers Collection

1. Click "Start collection"
2. Collection ID: `volunteers`
3. Document ID: `sample_volunteer` (or auto-generate)
4. Add fields:
   ```
   fullName (string): "Sample Volunteer"
   mobile (string): "01000000001"
   password (string): "password"
   notes (string): "Sample volunteer account"
   distributionArea (string): "sample_area"
   status (string): "active"
   createdAt (timestamp): [Current time]
   updatedAt (timestamp): [Current time]
   createdBy (string): "system"
   ```
5. Click "Save"

#### 6. entities Collection

1. Click "Start collection"
2. Collection ID: `entities`
3. Document ID: Auto-generate
4. Add fields:
   ```
   name (string): "UNHCR"
   createdAt (timestamp): [Current time]
   createdBy (string): "system"
   ```
5. Click "Save"

#### 7. queueHistory Collection

1. Click "Start collection"
2. Collection ID: `queueHistory`
3. Document ID: Auto-generate
4. Add fields:
   ```
   queueId (string): "sample_queue"
   beneficiaryId (string): "sample_beneficiary"
   action (string): "issued"
   queueNumber (number): 1
   performedBy (string): "system"
   performedAt (timestamp): [Current time]
   ```
5. Click "Save"

#### 8. reports Collection

1. Click "Start collection"
2. Collection ID: `reports`
3. Document ID: Auto-generate
4. Add fields:
   ```
   type (string): "daily"
   title (string): "Sample Report"
   data (map): {
     totalQueues: 1,
     activeQueues: 1,
     totalBeneficiaries: 1,
     servedBeneficiaries: 0
   }
   createdAt (timestamp): [Current time]
   createdBy (string): "system"
   ```
5. Click "Save"

## Step 3: Set Up Security Rules

1. In Firebase Console, go to "Firestore Database" → "Rules"
2. Copy the security rules from `FIRESTORE_DATABASE_STRUCTURE.md`
3. Paste and click "Publish"

## Step 4: Create Indexes

Firebase will prompt you to create indexes when needed, or you can create them manually:

1. Go to "Firestore Database" → "Indexes"
2. Click "Create Index"
3. Create indexes as listed in `FIRESTORE_DATABASE_STRUCTURE.md`

### Required Composite Indexes:

1. **queues**:
   - Fields: `distributionArea` (Ascending), `status` (Ascending), `fromDate` (Ascending)
   - Fields: `status` (Ascending), `isStarted` (Ascending), `createdAt` (Descending)

2. **beneficiaries**:
   - Fields: `distributionArea` (Ascending), `status` (Ascending), `queueNumber` (Ascending)
   - Fields: `distributionArea` (Ascending), `isServed` (Ascending), `createdAt` (Descending)

3. **queueHistory**:
   - Fields: `queueId` (Ascending), `performedAt` (Descending)
   - Fields: `beneficiaryId` (Ascending), `performedAt` (Descending)

## Step 5: Verify Setup

1. Check that all 8 collections exist
2. Verify at least one document exists in each collection
3. Test a query from your app
4. Check that indexes are created (may take a few minutes)

## Quick Setup Button in Your App

Add this to your admin screen for easy setup:

```dart
import 'scripts/setup_firebase_collections.dart';

ElevatedButton(
  onPressed: () async {
    try {
      await FirebaseCollectionsSetup.setupAllCollections();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Collections setup complete!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  },
  child: Text('Setup Firebase Collections'),
)
```

## Notes

- Collections are created automatically when first document is added
- Sample documents can be deleted after setup
- Indexes may take a few minutes to build
- Security rules should be updated before production use

