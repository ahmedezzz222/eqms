# Firestore Database Structure for EQMS App

## Overview
This document describes the complete Firestore database structure for the EQMS (Queue Management System) application.

## Collections

### 1. `distributionAreas` (Queue Points)
**Description**: Stores distribution areas/queue points where queues are managed.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "country": "string (e.g., 'Egypt')",
  "governorate": "string (e.g., 'Cairo')",
  "city": "string (e.g., 'Nasr City')",
  "areaName": "string (e.g., 'Nasr City Queue Point')",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

**Indexes**:
- `country` (ascending)
- `governorate` (ascending)
- `city` (ascending)

---

### 2. `queues`
**Description**: Stores all queue information.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "name": "string",
  "queueManager": "string (admin ID or name)",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "queuePointName": "string",
  "distributionArea": "string (reference to distributionAreas.id)",
  "queueType": "string ('Single Day' or 'Multi Day')",
  "fromDate": "timestamp",
  "toDate": "timestamp",
  "fromTime": {
    "hour": "number",
    "minute": "number"
  },
  "toTime": {
    "hour": "number",
    "minute": "number"
  },
  "unitName": "string (e.g., 'Meals', 'Bags', 'Blankets', 'Others')",
  "customUnitName": "string (if unitName is 'Others')",
  "numberOfAvailableUnits": "number",
  "estimatedQueueSize": "number",
  "directServe": "boolean",
  "priority": ["array of strings", "e.g., ['Female', 'Elderly', 'Disability']"],
  "status": "string ('active', 'banned', 'suspended')",
  "subtitle": "string (optional)",
  "isStarted": "boolean",
  "isCompleted": "boolean",
  "isSuspended": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "createdBy": "string (admin ID)"
}
```

**Indexes**:
- `distributionArea` (ascending)
- `status` (ascending)
- `fromDate` (ascending)
- `toDate` (ascending)
- `isStarted` (ascending)
- `isCompleted` (ascending)
- `createdAt` (descending)

**Subcollections**:
- `beneficiaries` - Beneficiaries assigned to this queue

---

### 3. `beneficiaries`
**Description**: Stores all beneficiary information.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "distributionArea": "string (reference to distributionAreas.id)",
  "initialAssignedQueuePoint": "string (queue name)",
  "type": "string ('Normal', 'Child', 'Widowed', 'Divorced', 'Disability', 'Sick', 'Elderly')",
  "idCopyPath": "string (Firebase Storage path, optional)",
  "gender": "string ('Male' or 'Female')",
  "name": "string",
  "idNumber": "string (unique, indexed)",
  "mobileNumber": "string (optional, indexed)",
  "isEntity": "boolean",
  "entityName": "string (optional, if isEntity is true)",
  "numberOfUnits": "string (e.g., '1', '2')",
  "nfcPreprintedCode": "string (optional, indexed)",
  "photoPath": "string (Firebase Storage path, optional)",
  "status": "string ('Active' or 'Banned')",
  "birthDate": "timestamp (optional)",
  "queueNumber": "number (optional, assigned queue number)",
  "isServed": "boolean",
  "unitsTaken": "number",
  "servedAt": "timestamp (optional)",
  "servedBy": "string (admin ID, optional)",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "createdBy": "string (admin ID or 'guest')"
}
```

**Indexes**:
- `distributionArea` (ascending)
- `idNumber` (ascending, unique)
- `mobileNumber` (ascending)
- `nfcPreprintedCode` (ascending)
- `status` (ascending)
- `queueNumber` (ascending)
- `isServed` (ascending)
- `createdAt` (descending)

---

### 4. `admins`
**Description**: Stores Q Admin accounts and requests.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "distributionPoint": "string",
  "distributionPointDescription": "string (optional)",
  "fullName": "string",
  "mobile": "string (unique, indexed)",
  "password": "string (hashed)",
  "notes": "string",
  "reference": "string (optional)",
  "status": "string ('pending', 'active', 'banned')",
  "isRequestedByGuest": "boolean",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "approvedBy": "string (admin ID, optional)",
  "approvedAt": "timestamp (optional)"
}
```

**Indexes**:
- `mobile` (ascending, unique)
- `status` (ascending)
- `distributionPoint` (ascending)
- `createdAt` (descending)

---

### 5. `volunteers` (Q Co-admins)
**Description**: Stores Q Co-admin accounts.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "fullName": "string",
  "mobile": "string (unique, indexed)",
  "password": "string (hashed)",
  "email": "string (optional)",
  "notes": "string",
  "reference": "string (optional)",
  "distributionArea": "string (reference to distributionAreas.id)",
  "status": "string ('active', 'banned')",
  "createdAt": "timestamp",
  "updatedAt": "timestamp",
  "createdBy": "string (admin ID)"
}
```

**Indexes**:
- `mobile` (ascending, unique)
- `distributionArea` (ascending)
- `status` (ascending)
- `createdAt` (descending)

---

### 6. `entities`
**Description**: Stores entity names for beneficiaries.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "name": "string (unique)",
  "createdAt": "timestamp",
  "createdBy": "string (admin ID)"
}
```

**Indexes**:
- `name` (ascending, unique)

---

### 7. `queueHistory`
**Description**: Stores historical records of queue operations.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "queueId": "string (reference to queues.id)",
  "beneficiaryId": "string (reference to beneficiaries.id)",
  "action": "string ('issued', 'served', 'cancelled')",
  "queueNumber": "number",
  "unitsServed": "number (optional)",
  "performedBy": "string (admin ID)",
  "performedAt": "timestamp",
  "notes": "string (optional)"
}
```

**Indexes**:
- `queueId` (ascending)
- `beneficiaryId` (ascending)
- `performedAt` (descending)
- `action` (ascending)

---

### 8. `reports`
**Description**: Stores generated reports.

**Document Structure**:
```json
{
  "id": "string (auto-generated)",
  "type": "string ('daily', 'weekly', 'monthly', 'custom')",
  "title": "string",
  "distributionArea": "string (optional)",
  "queueId": "string (optional)",
  "fromDate": "timestamp (optional)",
  "toDate": "timestamp (optional)",
  "data": {
    "totalQueues": "number",
    "activeQueues": "number",
    "totalBeneficiaries": "number",
    "servedBeneficiaries": "number",
    "totalUnitsServed": "number",
    "averageQueueTime": "number (minutes, optional)"
  },
  "createdAt": "timestamp",
  "createdBy": "string (admin ID)"
}
```

**Indexes**:
- `type` (ascending)
- `distributionArea` (ascending)
- `createdAt` (descending)

---

## Security Rules

### Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isAdmin() {
      return isAuthenticated() && 
             exists(/databases/$(database)/documents/admins/$(request.auth.uid)) &&
             get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.status == 'active';
    }
    
    function isVolunteer() {
      return isAuthenticated() && 
             exists(/databases/$(database)/documents/volunteers/$(request.auth.uid)) &&
             get(/databases/$(database)/documents/volunteers/$(request.auth.uid)).data.status == 'active';
    }
    
    // Distribution Areas
    match /distributionAreas/{areaId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
    
    // Queues
    match /queues/{queueId} {
      allow read: if isAuthenticated();
      allow create: if isAdmin();
      allow update, delete: if isAdmin();
      
      // Queue beneficiaries subcollection
      match /beneficiaries/{beneficiaryId} {
        allow read: if isAuthenticated();
        allow write: if isAdmin() || isVolunteer();
      }
    }
    
    // Beneficiaries
    match /beneficiaries/{beneficiaryId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated(); // Guests can self-register
      allow update: if isAdmin() || isVolunteer();
      allow delete: if isAdmin();
    }
    
    // Admins
    match /admins/{adminId} {
      allow read: if isAdmin();
      allow create: if isAuthenticated(); // Guests can request admin account
      allow update: if isAdmin();
      allow delete: if isAdmin();
    }
    
    // Volunteers
    match /volunteers/{volunteerId} {
      allow read: if isAdmin() || isVolunteer();
      allow create: if isAdmin();
      allow update: if isAdmin();
      allow delete: if isAdmin();
    }
    
    // Entities
    match /entities/{entityId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin();
    }
    
    // Queue History
    match /queueHistory/{historyId} {
      allow read: if isAuthenticated();
      allow write: if isAdmin() || isVolunteer();
    }
    
    // Reports
    match /reports/{reportId} {
      allow read: if isAdmin();
      allow write: if isAdmin();
    }
  }
}
```

---

## Storage Structure

### Firebase Storage Paths

```
/beneficiaries/
  {beneficiaryId}/
    id_copy/
      {timestamp}.jpg
    photo/
      {timestamp}.jpg

/admins/
  {adminId}/
    profile/
      {timestamp}.jpg
```

---

## Indexes Required

### Composite Indexes

1. **queues**:
   - `distributionArea` + `status` + `fromDate`
   - `status` + `isStarted` + `createdAt`
   - `distributionArea` + `isCompleted` + `createdAt`

2. **beneficiaries**:
   - `distributionArea` + `status` + `queueNumber`
   - `distributionArea` + `isServed` + `createdAt`
   - `idNumber` + `status`

3. **queueHistory**:
   - `queueId` + `performedAt`
   - `beneficiaryId` + `performedAt`

---

## Data Migration Notes

1. **TimeOfDay Conversion**: 
   - Store as `{hour: number, minute: number}` in Firestore
   - Convert to/from Flutter `TimeOfDay` in service layer

2. **Timestamps**: 
   - Use Firestore `Timestamp` type
   - Convert to/from Dart `DateTime` in service layer

3. **References**: 
   - Store as string IDs (not DocumentReference)
   - Use service methods to fetch related documents

4. **Unique Constraints**:
   - `beneficiaries.idNumber` - must be unique
   - `beneficiaries.mobileNumber` - should be unique (if provided)
   - `beneficiaries.nfcPreprintedCode` - should be unique (if provided)
   - `admins.mobile` - must be unique
   - `volunteers.mobile` - must be unique

---

## Setup Instructions

1. **Create Firebase Project**:
   - Go to Firebase Console
   - Create new project
   - Enable Firestore Database
   - Enable Firebase Authentication (Email/Password, Phone)

2. **Add Firebase to Flutter**:
   - Run `flutter pub get`
   - Follow Firebase Flutter setup guide
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

3. **Create Collections**:
   - Collections will be created automatically on first write
   - Or create them manually in Firebase Console

4. **Set Security Rules**:
   - Copy security rules to Firestore Rules tab
   - Publish rules

5. **Create Indexes**:
   - Firebase will prompt for required indexes
   - Or create manually in Firestore Indexes tab

6. **Initialize Firebase Storage**:
   - Enable Firebase Storage
   - Set storage rules
   - Configure storage paths

