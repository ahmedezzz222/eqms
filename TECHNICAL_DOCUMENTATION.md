# EQMS - Et3am Queue Management System
## Technical Documentation

**Version:** 1.1.0  
**Last Updated:** 2025  
**Technology Stack:** Flutter, Dart, Firebase (Firestore, Auth, Storage)

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Data Models](#data-models)
6. [Services Layer](#services-layer)
7. [UI Components & Screens](#ui-components--screens)
8. [Firebase Integration](#firebase-integration)
9. [Features](#features)
10. [Database Schema](#database-schema)
11. [Setup & Configuration](#setup--configuration)
12. [Development Guidelines](#development-guidelines)
13. [API Reference](#api-reference)

---

## Project Overview

EQMS (Electronic Queue Management System) is a comprehensive Flutter application designed to manage queue systems for distribution of resources (meals, bags, blankets, etc.) to beneficiaries. The system supports both admin users and guest users, with multi-language support (English/Arabic) and full Firebase backend integration.

### Key Capabilities

- Queue creation and management
- Beneficiary registration and tracking
- Distribution area (queue point) management
- Admin user management with role-based access
- Real-time queue status tracking
- Multi-language support (English/Arabic)
- Guest mode for beneficiary self-registration
- Queue number issuance and serving
- Reporting and statistics

### Target Users

1. **Super Admins**: Full system access, can create/manage admins
2. **Queue Admins**: Manage queues, beneficiaries, and serve resources
3. **Co-admins/Volunteers**: Assist with queue management
4. **Guests/Beneficiaries**: Register themselves and view queue status

---

## Architecture

### Architecture Pattern

The application follows a **layered architecture** pattern:

```
┌─────────────────────────────────────┐
│         UI Layer (Screens)          │
│  (StatefulWidget, StatelessWidget)  │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Business Logic Layer           │
│    (Services, Models, Utils)        │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      Data Layer (Firebase)          │
│  (Firestore, Auth, Storage)         │
└─────────────────────────────────────┘
```

### Key Design Principles

1. **Separation of Concerns**: Business logic separated from UI
2. **Service Pattern**: Centralized data access through service classes
3. **Stream-based Updates**: Real-time data using Firestore streams
4. **State Management**: Flutter's built-in StatefulWidget for local state
5. **Model-driven**: Data models define the structure and validation

### Data Flow

```
User Action → Screen Widget → Service Method → Firebase → Stream Update → UI Rebuild
```

---

## Technology Stack

### Frontend Framework
- **Flutter SDK**: ^3.10.1
- **Dart**: Latest stable version
- **Material Design**: UI components and theming

### Backend Services
- **Firebase Core**: ^3.6.0
- **Cloud Firestore**: ^5.4.4 (NoSQL database)
- **Firebase Auth**: ^5.3.1 (Authentication)
- **Firebase Storage**: ^12.3.4 (File storage)

### Additional Dependencies
- **excel**: ^4.0.0 (Excel file generation for reports)
- **path_provider**: ^2.1.4 (File system paths)
- **share_plus**: ^10.1.2 (File sharing functionality)
- **cross_file**: ^0.3.5 (Cross-platform file handling)
- **image_picker**: ^1.1.2 (Camera and gallery image selection)
- **image_cropper**: ^8.0.2 (Image cropping functionality)
- **flutter_native_ocr**: ^1.0.0 (OCR text recognition)
- **flutter_nfc_reader**: ^0.2.0 (NFC card reading)
- **permission_handler**: ^11.3.1 (Runtime permissions)
- **egyptian_id_parser**: ^1.1.0 (Egyptian ID number parsing)
- **image**: ^4.2.0 (Image processing and quality validation)

### Development Tools
- **FlutterFire CLI**: Firebase configuration
- **Flutter Lints**: ^6.0.0 (Code quality)

### Platform Support
- ✅ Android
- ✅ iOS
- ✅ Web

---

## Project Structure

```
eqmsapp/
├── lib/
│   ├── main.dart                 # Main entry point, app configuration, models, screens
│   ├── firebase_options.dart     # Auto-generated Firebase configuration
│   ├── screens/
│   │   └── setup_screen.dart     # Firebase setup screen
│   ├── services/
│   │   ├── firebase_service.dart           # Core Firebase initialization
│   │   ├── firebase_collections_setup.dart # Database structure setup
│   │   ├── admin_service.dart              # Admin CRUD operations
│   │   ├── admin_request_service.dart      # Admin request management
│   │   ├── role_service.dart               # Role and permission management
│   │   ├── beneficiary_service.dart        # Beneficiary CRUD operations
│   │   ├── queue_service.dart              # Queue CRUD operations
│   │   ├── distribution_area_service.dart  # Distribution area management
│   │   ├── entity_service.dart             # Entity management
│   │   ├── unit_service.dart               # Unit management
│   │   └── volunteer_service.dart          # Volunteer management
│   └── utils/
│       ├── firebase_init.dart        # Firebase initialization utilities
│       ├── firebase_migration.dart   # Data migration utilities
│       └── one_time_setup.dart       # One-time setup scripts
├── assets/
│   └── images/                    # App images and logos
├── android/                       # Android platform files
├── ios/                          # iOS platform files
├── web/                          # Web platform files
├── test/                         # Unit and widget tests
├── pubspec.yaml                  # Dependencies and configuration
└── README.md                     # Project readme
```

### Key Files Description

- **lib/main.dart**: Contains all UI screens, models, and app initialization (10,973 lines)
- **lib/services/**: Service layer for all data operations
- **lib/utils/**: Utility classes for Firebase setup and initialization

---

## Data Models

### Queue Model

```dart
class Queue {
  final String name;                    // Queue name
  final String queueManager;            // Manager name
  final String country;                 // Country (e.g., "Egypt")
  final String governorate;             // Governorate/Province
  final String city;                    // City
  final String queuePointName;          // Queue point name
  final String distributionArea;        // Distribution area ID
  final String queueType;               // "Single Day" or "Multi Day"
  final DateTime fromDate;              // Start date
  final DateTime toDate;                // End date
  final TimeOfDay fromTime;             // Start time
  final TimeOfDay toTime;               // End time
  final String unitName;                // "Meals", "Bags", "Blankets", "Others"
  final int numberOfAvailableUnits;     // Available units
  final int estimatedQueueSize;         // Estimated queue size
  final bool directServe;               // Allow direct serving
  final List<String> priority;          // Priority groups: ["Female", "Elderly", "Disability"]
  final String status;                  // "draft", "active", "suspended", "completed"
  final String? subtitle;               // Optional subtitle
  final bool isStarted;                 // Has queue started
  final bool isCompleted;               // Is queue completed
  final bool isSuspended;               // Is queue suspended
}
```

### Beneficiary Model

```dart
class Beneficiary {
  final String id;                          // Unique identifier
  final String distributionArea;            // Distribution area ID
  final String initialAssignedQueuePoint;   // Queue name assigned to
  final String type;                        // "Normal", "Child", "Widowed", "Divorced", "Sick"
  final String? idCopyPath;                 // ID copy file path
  final String gender;                      // "Male" or "Female"
  final String name;                        // Full name
  final String idNumber;                    // National ID number
  final String? mobileNumber;               // Mobile phone number
  final bool isEntity;                      // Is an entity/group
  final String? entityName;                 // Entity name if isEntity is true
  final String numberOfUnits;               // Number of units eligible for
  final String? nfcPreprintedCode;          // NFC card code
  final String? photoPath;                  // Photo file path
  final String status;                      // Beneficiary status
  final DateTime? birthDate;                // Birth date
  final int? queueNumber;                   // Assigned queue number
  final bool isServed;                      // Has been served
  final int unitsTaken;                     // Units already taken
}
```

### Admin Model

```dart
class Admin {
  final String id;                          // Unique identifier
  final String country;                     // Country
  final String governorate;                 // Governorate
  final String city;                        // City
  final String distributionPoint;           // Distribution point name
  final String? distributionPointDescription; // Point description
  final String fullName;                    // Admin full name
  final String mobile;                      // Mobile number
  final String? password;                   // Password (hashed in production)
  final String? role;                       // "Super_Admin", "Admin", "Q_Admin", or null
  final String notes;                       // Admin notes
  final String? reference;                  // Reference information
  final String status;                      // "pending", "active", "banned"
  final bool isRequestedByGuest;            // Requested by guest user
  final DateTime createdAt;                 // Creation timestamp
  
  // Helper getters
  bool get isSuperAdmin => role == 'Super_Admin';
  bool get isAdmin => role == 'Admin';
  bool get isQAdmin => role == 'Q_Admin';
}
```

**Role Types**:
- `Super_Admin`: Full system access, can manage all admins
- `Admin`: Can manage queues and beneficiaries within their scope
- `Q_Admin`: Queue administrator with access to assigned queues only

### DistributionArea Model

```dart
class DistributionArea {
  final String id;              // Unique identifier
  final String country;         // Country
  final String governorate;     // Governorate/Province
  final String city;            // City
  final String areaName;        // Area/Queue point name
}
```

---

## Services Layer

### FirebaseService

Core service for Firebase initialization and utilities.

**Location**: `lib/services/firebase_service.dart`

**Key Methods**:
- `initialize({String? databaseId})`: Initialize Firebase with optional named database
- `timeOfDayToMap(TimeOfDay)`: Convert TimeOfDay to Map for Firestore
- `mapToTimeOfDay(Map)`: Convert Map to TimeOfDay
- `dateTimeToTimestamp(DateTime)`: Convert DateTime to Firestore Timestamp
- `timestampToDateTime(Timestamp)`: Convert Timestamp to DateTime

**Properties**:
- `firestore`: FirebaseFirestore instance
- `auth`: FirebaseAuth instance
- `storage`: FirebaseStorage instance
- `isInitialized`: Boolean flag for initialization status

### QueueService

Manages queue operations in Firestore.

**Location**: `lib/services/queue_service.dart`

**Key Methods**:
- `getAllQueues()`: Stream<List<Queue>> - Get all queues
- `getQueuesByArea(String areaId)`: Stream<List<Queue>> - Get queues by distribution area
- `getQueueById(String id)`: Future<Queue?> - Get single queue
- `createQueue(Queue queue, String createdBy)`: Future<String> - Create new queue
- `updateQueue(String id, Queue queue)`: Future<void> - Update queue
- `deleteQueue(String id)`: Future<void> - Delete queue
- `startQueue(String id)`: Future<void> - Start a queue
- `suspendQueue(String id)`: Future<void> - Suspend a queue
- `resumeQueue(String id)`: Future<void> - Resume suspended queue
- `completeQueue(String id)`: Future<void> - Complete a queue

### BeneficiaryService

Manages beneficiary operations.

**Location**: `lib/services/beneficiary_service.dart`

**Key Methods**:
- `getAllBeneficiaries()`: Stream<List<Beneficiary>> - Get all beneficiaries
- `getBeneficiariesByArea(String areaId)`: Stream<List<Beneficiary>> - Get by area
- `getBeneficiariesByQueueName(String queueName)`: Stream<List<Beneficiary>> - Get by queue
- `getBeneficiaryById(String id)`: Future<Beneficiary?> - Get single beneficiary
- `createBeneficiary(Beneficiary beneficiary)`: Future<String> - Create beneficiary
- `updateBeneficiary(String id, Beneficiary beneficiary)`: Future<void> - Update beneficiary
- `deleteBeneficiary(String id)`: Future<void> - Delete beneficiary
- `markAsServed(String id, int unitsTaken)`: Future<void> - Mark beneficiary as served
- `getServedBeneficiariesReport(String? distributionAreaId)`: Future<List<Map<String, dynamic>>> - Get served beneficiaries report with serving information

### AdminService

Manages admin user operations.

**Location**: `lib/services/admin_service.dart`

**Key Methods**:
- `getAllAdmins()`: Stream<List<Admin>> - Get all admins
- `getAdminById(String id)`: Future<Admin?> - Get admin by ID
- `getAdminByMobile(String mobile)`: Future<Admin?> - Get admin by mobile
- `authenticateAdmin(String mobile, String password)`: Future<Admin?> - Authenticate admin
- `createAdmin(Admin admin, String? password)`: Future<String> - Create admin
- `updateAdmin(String id, Admin admin)`: Future<void> - Update admin
- `approveAdminRequest(String id)`: Future<void> - Approve pending admin request
- `rejectAdminRequest(String id)`: Future<void> - Reject admin request
- `setCurrentAdmin(String adminId, Admin? admin)`: void - Set current logged-in admin
- `clearCurrentAdmin()`: void - Clear current admin (logout)

**Static Properties**:
- `currentAdminId`: Current admin ID
- `currentAdmin`: Current admin object

### DistributionAreaService

Manages distribution areas (queue points).

**Location**: `lib/services/distribution_area_service.dart`

**Key Methods**:
- `getAllAreas()`: Stream<List<DistributionArea>> - Get all areas
- `getAreaById(String id)`: Future<DistributionArea?> - Get area by ID
- `createArea(DistributionArea area)`: Future<String> - Create area
- `updateArea(String id, DistributionArea area)`: Future<void> - Update area
- `deleteArea(String id)`: Future<void> - Delete area

### AdminRequestService

Manages admin request workflow (separate from admin collection).

**Location**: `lib/services/admin_request_service.dart`

**Key Methods**:
- `createRequest(Admin admin, {bool isNewDistributionArea})`: Future<String> - Create admin request
- `getAllRequests()`: Stream<List<Admin>> - Get all pending requests
- `getAllRequestsHistory()`: Stream<List<Admin>> - Get all requests (pending, approved, rejected)
- `getPendingRequestsCount()`: Stream<int> - Get count of pending requests
- `getRequestById(String id)`: Future<Admin?> - Get request by ID
- `approveRequest(String requestId, String? role)`: Future<void> - Approve request and create admin
- `rejectRequest(String requestId)`: Future<void> - Reject admin request
- `deleteRequest(String id)`: Future<void> - Delete request

**Features**:
- Separate collection (`adminRequests`) for request workflow
- Automatic distribution area creation when approving requests with new areas
- Request status tracking (pending, approved, rejected)
- Links created admins to their requests via `adminId` field

### RoleService

Manages role definitions and permissions.

**Location**: `lib/services/role_service.dart`

**Key Methods**:
- `initializeDefaultRoles()`: Future<void> - Initialize default roles in Firestore
- `getAllRoles()`: Stream<List<Role>> - Get all roles
- `getRoleById(String id)`: Future<Role?> - Get role by ID
- `getRoleByName(String name)`: Future<Role?> - Get role by name
- `getRoleIdByName(String name)`: Future<String?> - Get role ID by name
- `createRole(Role role)`: Future<String> - Create new role
- `updateRole(String id, Role role)`: Future<void> - Update role
- `deleteRole(String id)`: Future<void> - Delete role

**Role Model**:
```dart
class Role {
  final String id;
  final String name;              // 'Super_Admin', 'Admin', 'Q_Admin'
  final String description;
  final List<String> permissions; // Permission list
  final DateTime createdAt;
}
```

**Default Roles**:
- **Super_Admin**: Full access (`permissions: ['all']`)
- **Admin**: Manage queues and beneficiaries (`permissions: ['manage_queues', 'manage_beneficiaries', 'view_reports']`)
- **Q_Admin**: Manage assigned queues only (`permissions: ['manage_assigned_queues', 'view_assigned_beneficiaries']`)

### Other Services

- **EntityService**: Manages entity/organization records
- **UnitService**: Manages unit definitions
- **VolunteerService**: Manages volunteer/co-admin records
- **FirebaseCollectionsSetup**: Sets up Firestore collection structure

---

## UI Components & Screens

### Screen Architecture

All screens are implemented in `lib/main.dart` as separate widget classes. The application uses Material Design components.

### Main Screens

#### 1. OnboardingScreen
- **Purpose**: Initial splash/logo screen
- **Features**: Animated logo display, transitions to login
- **User Type**: All users

#### 2. LoginScreen
- **Purpose**: Admin authentication
- **Features**: 
  - Mobile number and password login
  - Guest mode access button
  - OTP verification support
- **User Type**: Admins

#### 3. GuestDashboardScreen
- **Purpose**: Guest user dashboard
- **Features**:
  - Self-registration option
  - Admin account request
  - Queue viewing
  - **Note**: Live Text Detection button removed from guest dashboard
- **User Type**: Guests

#### 4. DashboardScreen
- **Purpose**: Main admin dashboard
- **Features**:
  - Statistics overview (total queues, active queues, beneficiaries, served)
  - Queue list with filtering
  - Quick actions (add queue, add beneficiary)
  - Navigation to other screens
- **User Type**: Admins

#### 5. NewQueueScreen / QueueDetailsScreen
- **Purpose**: Create and edit queues
- **Features**:
  - Queue configuration form
  - Date/time range selection
  - Unit type selection (Meals, Bags, Blankets, Others)
  - Priority settings
  - Direct serve options
- **User Type**: Admins

#### 6. BeneficiaryRegistrationScreen
- **Purpose**: Register new beneficiaries
- **Features**:
  - Personal information form
  - **Scan National ID** button (Live Text Detection integration)
  - Automatic form filling from scanned ID text
  - Multi-line name extraction (handles names split across 2 lines)
  - NFC code input
  - Photo capture (optional)
  - Entity/group registration
  - ID copy upload/capture
- **User Type**: Admins, Guests (self-registration)
- **ID Scanning**: Uses Live Text Detection screen for OCR-based data extraction

#### 7. BeneficiariesListScreen
- **Purpose**: View and manage beneficiaries
- **Features**:
  - List of all beneficiaries
  - Search and filter
  - Area-based filtering
  - Beneficiary details view
  - Edit beneficiary functionality with **Scan National ID** integration
- **User Type**: Admins

#### 8. QueueServingScreen
- **Purpose**: Serve beneficiaries in queue
- **Features**:
  - Queue number display
  - Beneficiary verification (ID, mobile, NFC)
  - Mark as served functionality
  - Units tracking
- **User Type**: Admins

#### 9. AdminManagementScreen
- **Purpose**: Manage admin users
- **Features**:
  - Create new admins
  - View admin requests
  - Approve/reject requests
  - Manage admin roles (Super_Admin, Admin, Q_Admin)
  - Link to admin requests screen
- **User Type**: Super Admins

#### 9a. AdminRequestsScreen
- **Purpose**: Manage admin requests workflow
- **Features**:
  - Tab-based interface (Pending, Approved, Rejected)
  - View all admin requests
  - Approve requests with role assignment
  - Reject requests
  - Automatic distribution area creation for new areas
  - Request details view
- **User Type**: Super Admins

#### 10. ReportsScreen
- **Purpose**: View statistics and reports
- **Features**:
  - Queue statistics
  - Beneficiary statistics
  - Visual cards with metrics
  - Distribution area filtering
  - Excel export functionality (export served beneficiaries report)
  - Real-time served beneficiaries listing with serving dates/times
- **User Type**: Admins (with role-based area filtering)
- **Export Features**:
  - Export selected area or all areas
  - Excel format (.xlsx)
  - Includes: Serving Date, Serving Time, Beneficiary Name, Distribution Area, Queue Point, Units, Unit Name
  - Cross-platform sharing (web/mobile)

#### 11. ProfileScreen
- **Purpose**: User profile and settings
- **Features**:
  - View current admin information
  - Change password functionality
  - Language selection (English/Arabic)
  - Logout option
- **User Type**: All authenticated users

#### 12. SettingsScreen
- **Purpose**: App settings
- **Features**:
  - Language selection (English/Arabic)
  - Notification preferences
  - Dark mode toggle (UI only)
  - App version info
  - Terms & Conditions link
  - Privacy Policy link
- **User Type**: All authenticated users

#### 13. LiveTextDetectionScreen
- **Purpose**: Live text detection using device camera
- **Features**:
  - Real-time text recognition
  - Camera-based scanning
  - Returns detected text to calling screen
  - Cross-platform support (Android/iOS)
- **User Type**: Admins, Guests (for ID scanning)
- **Integration**: Used by "Scan National ID" button in registration/edit screens

### Common UI Patterns

1. **Gradient Backgrounds**: Green gradient theme (`Color(0xFFE8F5E9)` to white)
2. **Teal Green Primary Color**: `Color(0xFF81CF01)` for buttons and app bars
3. **Card-based Layouts**: Statistics and information displayed in cards
4. **Form Validation**: Comprehensive form validation with error messages
5. **Loading States**: Stream-based reactive UI with loading indicators
6. **SnackBar Notifications**: User feedback via SnackBars

---

## Firebase Integration

### Firebase Services Used

1. **Cloud Firestore**: Primary database for all data
2. **Firebase Authentication**: Admin authentication (via custom implementation)
3. **Firebase Storage**: File storage for photos and ID copies

### Firestore Collections

#### 1. `queues`
Stores queue information.

**Document Structure**:
```json
{
  "name": "string",
  "queueManager": "string",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "queuePointName": "string",
  "distributionArea": "string",
  "queueType": "Single Day" | "Multi Day",
  "fromDate": Timestamp,
  "toDate": Timestamp,
  "fromTime": { "hour": int, "minute": int },
  "toTime": { "hour": int, "minute": int },
  "unitName": "Meals" | "Bags" | "Blankets" | "Others",
  "customUnitName": "string" (if unitName is "Others"),
  "numberOfAvailableUnits": int,
  "estimatedQueueSize": int,
  "directServe": boolean,
  "priority": ["Female", "Elderly", "Disability"],
  "status": "draft" | "active" | "suspended" | "completed",
  "subtitle": "string" (optional),
  "isStarted": boolean,
  "isCompleted": boolean,
  "isSuspended": boolean,
  "createdAt": Timestamp,
  "updatedAt": Timestamp,
  "createdBy": "string" (admin ID)
}
```

#### 2. `beneficiaries`
Stores beneficiary information.

**Document Structure**:
```json
{
  "id": "string",
  "distributionArea": "string",
  "initialAssignedQueuePoint": "string",
  "type": "Normal" | "Child" | "Widowed" | "Divorced" | "Sick",
  "idCopyPath": "string" (optional),
  "gender": "Male" | "Female",
  "name": "string",
  "idNumber": "string",
  "mobileNumber": "string" (optional),
  "isEntity": boolean,
  "entityName": "string" (optional),
  "numberOfUnits": "string",
  "nfcPreprintedCode": "string" (optional),
  "photoPath": "string" (optional),
  "status": "string",
  "birthDate": Timestamp (optional),
  "queueNumber": int (optional),
  "isServed": boolean,
  "unitsTaken": int,
  "servedAt": Timestamp (optional, set when beneficiary is served),
  "servedBy": "string" (optional, admin ID who served the beneficiary),
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

#### 3. `admins`
Stores admin user information.

**Document Structure**:
```json
{
  "id": "string",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "distributionPoint": "string",
  "distributionPointDescription": "string" (optional),
  "fullName": "string",
  "mobile": "string",
  "password": "string" (should be hashed),
  "role": "Super_Admin" | "Admin" | "Q_Admin" | null,
  "notes": "string",
  "reference": "string" (optional),
  "status": "pending" | "active" | "banned",
  "isRequestedByGuest": boolean,
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

#### 4. `distributionAreas`
Stores distribution area/queue point information.

**Document Structure**:
```json
{
  "id": "string",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "areaName": "string",
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

#### 4a. `adminRequests`
Stores admin account requests (separate from admins collection).

**Document Structure**:
```json
{
  "id": "string",
  "country": "string",
  "governorate": "string",
  "city": "string",
  "distributionPoint": "string",
  "distributionPointDescription": "string" (optional),
  "fullName": "string",
  "mobile": "string",
  "password": "string",
  "role": "Super_Admin" | "Admin" | "Q_Admin" | null,
  "notes": "string",
  "reference": "string" (optional),
  "status": "pending" | "approved" | "rejected",
  "isRequestedByGuest": boolean,
  "isNewDistributionArea": boolean,
  "adminId": "string" (optional, set when approved),
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

#### 4b. `roles`
Stores role definitions and permissions.

**Document Structure**:
```json
{
  "id": "string",
  "name": "Super_Admin" | "Admin" | "Q_Admin",
  "description": "string",
  "permissions": ["all"] | ["manage_queues", "manage_beneficiaries", "view_reports"] | ["manage_assigned_queues", "view_assigned_beneficiaries"],
  "createdAt": Timestamp
}
```

#### 5. `entities`
Stores entity/organization information.

**Document Structure**:
```json
{
  "name": "string",
  "createdAt": Timestamp,
  "createdBy": "string"
}
```

#### 6. `volunteers`
Stores volunteer/co-admin information.

#### 7. `queueHistory`
Stores historical queue serving records.

### Firebase Security Rules

⚠️ **Important**: Firestore security rules should be configured based on your requirements. Currently, the app assumes rules are set up appropriately for your use case.

**Recommended Rules Structure**:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Admins collection - only admins can read/write
    match /admins/{adminId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                     get(/databases/$(database)/documents/admins/$(request.auth.uid)).data.role == 'super_admin';
    }
    
    // Queues - authenticated admins can read/write
    match /queues/{queueId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Beneficiaries - authenticated users can read, admins can write
    match /beneficiaries/{beneficiaryId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Distribution areas - authenticated users can read, admins can write
    match /distributionAreas/{areaId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

### Firebase Indexes

Some queries require composite indexes. Firebase Console will prompt you to create these when needed, or you can create them manually.

**Common Indexes Needed**:
- `queues`: `distributionArea` (ASC), `createdAt` (DESC)
- `beneficiaries`: `distributionArea` (ASC), `createdAt` (DESC)
- `beneficiaries`: `initialAssignedQueuePoint` (ASC), `createdAt` (DESC)
- `beneficiaries`: `isServed` (ASC), `distributionArea` (ASC) (for served beneficiaries report)
- `adminRequests`: `status` (ASC), `createdAt` (DESC)

---

## Features

### Core Features

#### 1. Queue Management
- ✅ Create queues with date/time ranges
- ✅ Single day and multi-day queue support
- ✅ Unit type selection (Meals, Bags, Blankets, Custom)
- ✅ Priority groups (Female, Elderly, Disability)
- ✅ Direct serve option (serving without tickets)
- ✅ Queue status management (draft, active, suspended, completed)
- ✅ Queue filtering by distribution area

#### 2. Beneficiary Management
- ✅ Register beneficiaries with personal information
- ✅ **Scan National ID** with Live Text Detection integration
- ✅ Automatic form filling from scanned ID (ID number, name, birth date, gender)
- ✅ Multi-line name extraction (handles names split across 2 lines)
- ✅ ID number tracking and validation (12-14 digits)
- ✅ Arabic-Indic digit conversion support
- ✅ NFC code support
- ✅ Photo capture and storage
- ✅ ID copy upload/capture
- ✅ Entity/group registration
- ✅ Queue number assignment
- ✅ Serving tracking (units taken, served status)
- ✅ Search and filter beneficiaries
- ✅ Edit beneficiary with ID scanning support

#### 3. Admin Management
- ✅ Admin user creation
- ✅ Role-based access (Super_Admin, Admin, Q_Admin)
- ✅ Admin request approval workflow (separate collection)
- ✅ Guest-to-admin request system
- ✅ Admin authentication
- ✅ Password change functionality
- ✅ Admin request history (Pending, Approved, Rejected)
- ✅ Role management with permissions
- ✅ Automatic distribution area creation on request approval

#### 4. Distribution Area Management
- ✅ Create and manage queue points
- ✅ Hierarchical structure (Country > Governorate > City > Area)
- ✅ Area-based filtering
- ✅ Automatic creation when approving admin requests with new areas

#### 5. Queue Serving
- ✅ Real-time queue number display
- ✅ Beneficiary verification (ID, mobile, NFC)
- ✅ Mark beneficiaries as served
- ✅ Units tracking

#### 6. Reporting & Statistics
- ✅ Dashboard statistics
- ✅ Queue metrics
- ✅ Beneficiary metrics
- ✅ Served beneficiaries tracking
- ✅ Excel export functionality
- ✅ Distribution area filtering in reports
- ✅ Served beneficiaries report with serving dates/times
- ✅ Cross-platform file sharing (web/mobile)

#### 7. Multi-language Support
- ✅ English language
- ✅ Arabic language (RTL support)
- ✅ Language switching at runtime

#### 8. Guest Mode
- ✅ Guest access without authentication
- ✅ Self-registration for beneficiaries
- ✅ Admin account request
- ✅ Queue viewing

### Recently Added Features

#### ID Scanning & OCR (v1.1.0)
- ✅ **Scan National ID** button with Live Text Detection integration
- ✅ Multiple OCR strategies (region-based, full image, original, grayscale)
- ✅ Automatic form filling from scanned ID text
- ✅ Multi-line name extraction (handles names split across 2 lines)
- ✅ Arabic-Indic digit conversion (Persian and Arabic variants)
- ✅ Enhanced ID number extraction (accepts 12-14 digits)
- ✅ Automatic birth date extraction and Elderly type detection
- ✅ Improved Arabic name extraction with phrase filtering
- ✅ Image quality validation before OCR processing
- ✅ Applied to both registration and edit beneficiary screens
- ✅ Removed clipboard text detection popup on screen open

#### Excel Export (v1.0.0)
- ✅ Export served beneficiaries reports to Excel
- ✅ Filter by distribution area or export all areas
- ✅ Cross-platform sharing (web/mobile)
- ✅ Includes serving date, time, beneficiary details, and unit information

#### Enhanced Admin Management (v1.0.0)
- ✅ Separate admin requests collection for better workflow
- ✅ Role-based access control (Super_Admin, Admin, Q_Admin)
- ✅ Password change functionality
- ✅ Admin request history with status filtering
- ✅ Automatic distribution area creation

#### Enhanced Reporting (v1.0.0)
- ✅ Distribution area filtering
- ✅ Served beneficiaries report with serving timestamps
- ✅ Excel export functionality
- ✅ Real-time report updates

#### UI Improvements (v1.1.0)
- ✅ Fixed bottom overflow in dashboard queue list
- ✅ Improved spacing and padding in queue list
- ✅ Better layout constraints for scrollable content

### Future Enhancements

Potential areas for improvement:
- Push notifications
- Offline mode support
- Advanced reporting and analytics
- PDF export functionality
- QR code generation for queue numbers
- SMS notifications
- Biometric authentication
- Advanced search and filtering
- Bulk operations
- Data visualization (charts/graphs)

---

## Database Schema

### Entity Relationship Diagram (Conceptual)

```
DistributionArea (1) ────< (N) Queue
Queue (1) ────< (N) Beneficiary
Admin (1) ────< (N) Queue (createdBy)
Admin (1) ────< (N) Beneficiary (registeredBy)
```

### Collection Relationships

1. **Queues** reference **DistributionAreas** via `distributionArea` field
2. **Beneficiaries** reference **Queues** via `initialAssignedQueuePoint` field
3. **Beneficiaries** reference **DistributionAreas** via `distributionArea` field
4. **Queues** reference **Admins** via `createdBy` field

### Data Validation

Validation is performed at the application level:
- Required fields are validated in forms
- Egyptian mobile number format validation (regex: `^01[0-2,5]{1}[0-9]{8}$`)
- Date/time range validation
- Queue number uniqueness within a queue
- ID number uniqueness validation

---

## Setup & Configuration

### Prerequisites

1. **Flutter SDK**: Version 3.10.1 or higher
2. **Dart SDK**: Included with Flutter
3. **Firebase Account**: Google account with Firebase project
4. **Development Environment**:
   - Android Studio / VS Code
   - Android SDK (for Android development)
   - Xcode (for iOS development, macOS only)

### Initial Setup

#### 1. Clone and Install Dependencies

```bash
# Clone the repository (if applicable)
git clone <repository-url>
cd eqmsapp

# Install Flutter dependencies
flutter pub get
```

#### 2. Firebase Setup

**Using FlutterFire CLI** (Recommended):

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure

# Follow the prompts to:
# - Select your Firebase project
# - Select platforms (Android, iOS, Web)
# - Configure for each platform
```

**Manual Setup**:

1. Create Firebase project at https://console.firebase.google.com
2. Enable Firestore Database
3. Enable Firebase Authentication (if using)
4. Enable Firebase Storage (if using)
5. Download configuration files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
6. Update `lib/firebase_options.dart` (or generate with FlutterFire CLI)

#### 3. Firestore Database Setup

**Create Collections**:

The app includes automatic collection setup via `FirebaseCollectionsSetup.setupAllCollections()`, which runs on app initialization.

**Manual Collection Creation**:

Create the following collections in Firestore:
- `queues`
- `beneficiaries`
- `admins`
- `adminRequests` (for admin request workflow)
- `distributionAreas`
- `entities`
- `volunteers`
- `queueHistory`
- `roles` (for role definitions)

**Note**: Default roles are automatically created via `RoleService.initializeDefaultRoles()` if not present.

#### 4. Configure Security Rules

Set up Firestore security rules as per your requirements (see Firebase Integration section).

#### 5. Platform-Specific Configuration

**Android**:
- Update `android/app/build.gradle.kts` with package name
- Ensure `google-services.json` is in `android/app/`
- Set minimum SDK version (typically 21+)

**iOS**:
- Update bundle identifier in Xcode
- Ensure `GoogleService-Info.plist` is in `ios/Runner/`
- Configure signing & capabilities in Xcode

**Web**:
- Firebase configuration is handled via `firebase_options.dart`

### Running the Application

```bash
# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome        # Web
flutter run -d android       # Android
flutter run -d ios           # iOS

# Build for release
flutter build apk            # Android APK
flutter build appbundle      # Android App Bundle
flutter build ios            # iOS
flutter build web            # Web
```

### First-Time Setup

1. Run the application
2. Firebase collections will be automatically created
3. Create the first super admin via admin management screen
4. Configure distribution areas
5. Start creating queues and registering beneficiaries

---

## Development Guidelines

### Code Style

- Follow Dart style guide: https://dart.dev/guides/language/effective-dart/style
- Use `flutter_lints` package for linting
- Format code: `dart format .`
- Analyze code: `flutter analyze`

### Naming Conventions

- **Files**: snake_case (e.g., `firebase_service.dart`)
- **Classes**: PascalCase (e.g., `QueueService`)
- **Variables/Functions**: camelCase (e.g., `getAllQueues`)
- **Constants**: lowerCamelCase with `const` (e.g., `const primaryColor`)
- **Private members**: Prefix with underscore (e.g., `_currentAdmin`)

### Code Organization

1. **Models**: Data classes at the top of `main.dart` or separate files
2. **Services**: One service class per file in `lib/services/`
3. **Screens**: Widget classes in `main.dart` (consider separating into individual files for larger projects)
4. **Utils**: Utility functions in `lib/utils/`

### Best Practices

1. **Error Handling**:
   - Use try-catch blocks for async operations
   - Show user-friendly error messages
   - Log errors for debugging

2. **State Management**:
   - Use `StatefulWidget` for local state
   - Use `StreamBuilder` for Firestore streams
   - Avoid unnecessary rebuilds

3. **Firebase Operations**:
   - Always check `FirebaseService.isInitialized` before operations
   - Handle offline scenarios gracefully
   - Use transactions for critical operations

4. **UI/UX**:
   - Show loading indicators for async operations
   - Provide feedback via SnackBars
   - Validate forms before submission
   - Support RTL for Arabic language

5. **Security**:
   - Never commit Firebase credentials to version control
   - Hash passwords before storage (implement in production)
   - Validate user input on both client and server
   - Implement proper Firestore security rules

### Testing

Currently, the project includes a basic test file. Consider adding:

1. **Unit Tests**: Test service methods and utilities
2. **Widget Tests**: Test UI components
3. **Integration Tests**: Test complete user flows

**Run Tests**:
```bash
flutter test
```

### Version Control

**Recommended .gitignore entries**:
```
# Firebase
**/google-services.json
**/GoogleService-Info.plist
lib/firebase_options.dart (if contains sensitive data)

# Build
build/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies

# IDE
.idea/
.vscode/
*.iml

# OS
.DS_Store
Thumbs.db
```

---

## API Reference

### Service Methods Quick Reference

#### QueueService

```dart
// Get all queues (stream)
Stream<List<Queue>> getAllQueues()

// Get queues by area (stream)
Stream<List<Queue>> getQueuesByArea(String distributionAreaId)

// Get single queue
Future<Queue?> getQueueById(String id)

// Create queue
Future<String> createQueue(Queue queue, String createdBy)

// Update queue
Future<void> updateQueue(String id, Queue queue)

// Delete queue
Future<void> deleteQueue(String id)

// Queue lifecycle
Future<void> startQueue(String id)
Future<void> suspendQueue(String id)
Future<void> resumeQueue(String id)
Future<void> completeQueue(String id)
```

#### BeneficiaryService

```dart
// Get all beneficiaries (stream)
Stream<List<Beneficiary>> getAllBeneficiaries()

// Get beneficiaries by area (stream)
Stream<List<Beneficiary>> getBeneficiariesByArea(String areaId)

// Get beneficiaries by queue (stream)
Stream<List<Beneficiary>> getBeneficiariesByQueueName(String queueName)

// Get single beneficiary
Future<Beneficiary?> getBeneficiaryById(String id)

// Create beneficiary
Future<String> createBeneficiary(Beneficiary beneficiary)

// Update beneficiary
Future<void> updateBeneficiary(String id, Beneficiary beneficiary)

// Delete beneficiary
Future<void> deleteBeneficiary(String id)

// Mark as served
Future<void> markAsServed(String id, int unitsTaken)
```

#### AdminService

```dart
// Get all admins (stream)
Stream<List<Admin>> getAllAdmins()

// Get admin by ID
Future<Admin?> getAdminById(String id)

// Get admin by mobile
Future<Admin?> getAdminByMobile(String mobile)

// Authenticate admin
Future<Admin?> authenticateAdmin(String mobile, String password)

// Create admin
Future<String> createAdmin(Admin admin, String? password)

// Update admin
Future<void> updateAdmin(String id, Admin admin)

// Current admin management
static String? currentAdminId
static Admin? currentAdmin
static void setCurrentAdmin(String adminId, Admin? admin)
static void clearCurrentAdmin()
```

#### AdminRequestService

```dart
// Create admin request
Future<String> createRequest(Admin admin, {bool isNewDistributionArea})

// Get all pending requests (stream)
Stream<List<Admin>> getAllRequests()

// Get all requests history (stream)
Stream<List<Admin>> getAllRequestsHistory()

// Get pending requests count (stream)
Stream<int> getPendingRequestsCount()

// Get request by ID
Future<Admin?> getRequestById(String id)

// Approve request (creates admin and distribution area if needed)
Future<void> approveRequest(String requestId, String? role)

// Reject request
Future<void> rejectRequest(String requestId)

// Delete request
Future<void> deleteRequest(String id)
```

#### RoleService

```dart
// Initialize default roles
Future<void> initializeDefaultRoles()

// Get all roles (stream)
Stream<List<Role>> getAllRoles()

// Get role by ID
Future<Role?> getRoleById(String id)

// Get role by name
Future<Role?> getRoleByName(String name)

// Get role ID by name
Future<String?> getRoleIdByName(String name)

// Create role
Future<String> createRole(Role role)

// Update role
Future<void> updateRole(String id, Role role)

// Delete role
Future<void> deleteRole(String id)
```

#### DistributionAreaService

```dart
// Get all areas (stream)
Stream<List<DistributionArea>> getAllAreas()

// Get area by ID
Future<DistributionArea?> getAreaById(String id)

// Create area
Future<String> createArea(DistributionArea area)

// Update area
Future<void> updateArea(String id, DistributionArea area)

// Delete area
Future<void> deleteArea(String id)
```

### Language Management

```dart
// Get translation
String AppLanguage.translate(String key)

// Set language
void AppLanguage.setLanguage(String language)

// Current language
String AppLanguage.currentLanguage

// Is Arabic?
bool AppLanguage.isArabic

// Text direction
TextDirection AppLanguage.textDirection

// Language notifier (for ValueListenableBuilder)
ValueNotifier<String> AppLanguage.languageNotifier
```

### OCR & ID Scanning Utilities

#### IDParser Class
Located in `lib/main.dart`, provides ID text parsing utilities.

**Key Methods**:
```dart
// Parse ID text and extract data
static Map<String, dynamic> parseIDText(String text)
// Returns: {'idNumber', 'name', 'birthDate', 'gender', 'birthLocation'}

// Extract birth date from 14-digit ID number
static DateTime? extractBirthDateFromIDNumber(String idNumber)

// Convert Arabic-Indic digits to Western digits
static String convertArabicIndicToWestern(String text)
// Handles: Persian (۰۱۲۳۴۵۶۷۸۹) and Arabic (٠١٢٣٤٥٦٧٨٩) variants
```

#### ImageQualityValidator Class
Located in `lib/main.dart`, validates and preprocesses images for OCR.

**Key Methods**:
```dart
// Validate image quality (brightness, contrast, blur)
static Future<Map<String, dynamic>> validateImageQuality(String imagePath)
// Returns: {'isValid', 'score', 'issues', 'recommendations'}

// Preprocess image for OCR (resize, grayscale, threshold, sharpen)
static Future<img.Image?> preprocessImage(String imagePath, {
  int targetWidth = 1000,
  int targetHeight = 630,
  bool applyThreshold = true,
  bool applySharpening = true,
})

// Extract regions from image (name, address, ID regions)
static Future<Map<String, String?>> extractRegionsFromImage(String imagePath)
// Returns: {'nameRegion', 'addressRegion', 'idRegion', 'idRegionAdaptive'}
```

#### LiveTextDetectionScreen
Located in `lib/live_text_detection_screen.dart`, provides live text detection interface.

**Features**:
- Camera-based text detection
- Real-time text recognition
- Returns detected text to calling screen
- Supports both Android and iOS

#### GoogleLensResultHelper
Located in `lib/google_lens_result_helper.dart`, monitors clipboard for Google Lens results.

**Key Methods**:
```dart
// Start monitoring clipboard for Google Lens results
static void startMonitoring(Function(String) onTextDetected)

// Stop monitoring
static void stopMonitoring()

// Get current clipboard text
static Future<String?> getClipboardText()
```

---

## Troubleshooting

### Common Issues

#### 1. Firebase Not Initialized

**Symptoms**: Errors about Firebase not being initialized

**Solutions**:
- Ensure `flutterfire configure` has been run
- Check that `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) exists
- Verify Firebase project configuration
- Check console logs for initialization errors

#### 2. Firestore Permission Denied

**Symptoms**: Permission denied errors when reading/writing

**Solutions**:
- Check Firestore security rules
- Verify user authentication status
- Ensure proper role assignments for admins

#### 3. Collection Does Not Exist

**Symptoms**: Errors about missing collections

**Solutions**:
- Let the app run - collections are created automatically on first run
- Manually create collections in Firebase Console if needed
- Check `FirebaseCollectionsSetup.setupAllCollections()` logs

#### 4. Language Not Switching

**Symptoms**: Language change not reflecting in UI

**Solutions**:
- Ensure `ValueListenableBuilder` wraps MaterialApp
- Check that translations exist for the selected language
- Verify `AppLanguage.setLanguage()` is called

#### 5. Stream Not Updating

**Symptoms**: Data not updating in real-time

**Solutions**:
- Verify Firestore connection
- Check StreamBuilder is properly implemented
- Ensure data is actually being updated in Firestore
- Check for error handling that might be swallowing errors

### Debug Tips

1. **Enable Logging**: Check console logs for error messages
2. **Firestore Console**: Use Firebase Console to verify data
3. **Flutter DevTools**: Use Flutter DevTools for debugging
4. **Network Inspection**: Check network requests in browser DevTools (for web)

---

## Contributing

### Development Workflow

1. Create feature branch from main
2. Make changes following code style guidelines
3. Test thoroughly
4. Submit pull request with description

### Code Review Checklist

- [ ] Code follows style guidelines
- [ ] Error handling is implemented
- [ ] UI is responsive and accessible
- [ ] Multi-language support (if UI changes)
- [ ] No hardcoded values
- [ ] Proper comments for complex logic
- [ ] Firebase operations are safe

---

## License

[Specify your license here]

---

## Support & Contact

[Add support contact information]

---

## Changelog

### Version 1.1.0 (Latest)
- **ID Scanning & OCR Enhancements**:
  - Added "Scan National ID" button with Live Text Detection integration
  - Multiple OCR strategies for better text recognition
  - Multi-line name extraction (handles names split across 2 lines)
  - Arabic-Indic digit conversion support
  - Enhanced ID number extraction (12-14 digits)
  - Automatic birth date extraction and Elderly type detection
  - Improved Arabic name extraction with phrase filtering
  - Image quality validation before OCR
  - Applied to registration and edit beneficiary screens
  - Removed clipboard text detection popup on screen open
- **UI Fixes**:
  - Fixed bottom overflow in dashboard queue list (17 pixels)
  - Improved spacing and padding in queue list
  - Better layout constraints for scrollable content
- **Guest Mode Updates**:
  - Removed Live Text Detection button from guest dashboard

### Version 1.0.0
- Initial release
- Queue management
- Beneficiary management
- Admin management with role-based access (Super_Admin, Admin, Q_Admin)
- Multi-language support (English/Arabic)
- Firebase integration
- Guest mode
- Excel export functionality for reports
- Admin request workflow (separate collection)
- Role management system
- Password change functionality
- Distribution area filtering in reports
- Served beneficiaries report with serving timestamps
- Enhanced admin management screen with request history
- Cross-platform file sharing (web/mobile)

---

**Document Generated**: January 2025  
**For**: EQMS Development Team  
**Last Updated**: January 2025

