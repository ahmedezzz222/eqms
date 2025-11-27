import 'package:flutter/material.dart';

// Language Manager
class AppLanguage {
  static String currentLanguage = 'English';
  static final ValueNotifier<String> languageNotifier = ValueNotifier<String>('English');
  
  static Map<String, Map<String, String>> translations = {
    'English': {
      // Common
      'Settings': 'Settings',
      'Profile': 'Profile',
      'Logout': 'Logout',
      'Dashboard': 'Dashboard',
      'Reports': 'Reports',
      'Admin Management': 'Admin Management',
      'Add Volunteer': 'Add Volunteer',
      'Preferences': 'Preferences',
      'Language': 'Language',
      'Enable Notifications': 'Enable Notifications',
      'Dark Mode': 'Dark Mode',
      'About': 'About',
      'App Version': 'App Version',
      'Terms & Conditions': 'Terms & Conditions',
      'Privacy Policy': 'Privacy Policy',
      'Select Language': 'Select Language',
      'English': 'English',
      'Arabic': 'Arabic',
      'EQMS Dashboard': 'EQMS Dashboard',
      'Total Queues': 'Total Queues',
      'Active Queues': 'Active Queues',
      'Total Beneficiaries': 'Total Beneficiaries',
      'Served Beneficiaries': 'Served Beneficiaries',
      'Statistics Overview': 'Statistics Overview',
      'Queue Details': 'Queue Details',
      'Status': 'Status',
      'units': 'units',
      'Add Queue': 'Add Queue',
      'Add Beneficiary': 'Add Beneficiary',
      'Beneficiaries': 'Beneficiaries',
      'Add Area': 'Add Area',
      'Issue Queue Number': 'Issue Queue Number',
      'Login': 'Login',
      'Register': 'Register',
      'Cancel': 'Cancel',
      'Save': 'Save',
      'Delete': 'Delete',
      'Edit': 'Edit',
      'View': 'View',
      'Start': 'Start',
      'Suspend': 'Suspend',
      'Complete': 'Complete',
      'Resume': 'Resume',
      // Login & Auth
      'Sign In': 'Sign In',
      'Continue as Guest': 'Continue as Guest',
      'Mobile Number': 'Mobile Number',
      'Password': 'Password',
      'Enter mobile number': 'Enter mobile number',
      'Enter password': 'Enter password',
      'Please enter your mobile number': 'Please enter your mobile number',
      'Please enter your password': 'Please enter your password',
      'Enter your mobile number': 'Enter your mobile number',
      'Enter your password': 'Enter your password',
      'OR': 'OR',
      // Guest Mode
      'Guest Mode': 'Guest Mode',
      'Welcome Guest': 'Welcome Guest',
      'Register yourself as a beneficiary': 'Register yourself as a beneficiary',
      'Register as Beneficiary': 'Register as Beneficiary',
      'Request Admin Account': 'Request Admin Account',
      // Queue Management
      'Queue Name': 'Queue Name',
      'Queue Manager': 'Queue Manager',
      'Queue Type': 'Queue Type',
      'Single Day': 'Single Day',
      'Multi Day': 'Multi Day',
      'From Date': 'From Date',
      'To Date': 'To Date',
      'From Time': 'From Time',
      'To Time': 'To Time',
      'Select Date': 'Select Date',
      'Select Time': 'Select Time',
      'Unit Name': 'Unit Name',
      'Meals': 'Meals',
      'Bags': 'Bags',
      'Blankets': 'Blankets',
      'Others': 'Others',
      'Custom Unit Name': 'Custom Unit Name',
      'Number of Available Units': 'Number of Available Units',
      'Estimated Queue Size': 'Estimated Queue Size',
      'Direct Serve Option': 'Direct Serve Option',
      'Priority': 'Priority',
      'Female': 'Female',
      'Elderly': 'Elderly',
      'Disability': 'Disability',
      'Create Queue': 'Create Queue',
      'Update Queue': 'Update Queue',
      'Queue created successfully': 'Queue created successfully',
      'Queue updated successfully': 'Queue updated successfully',
      // Beneficiary
      'Beneficiary Registration': 'Beneficiary Registration',
      'Self Registration': 'Self Registration',
      'Initial Assigned Queue Point': 'Initial Assigned Queue Point',
      'Type': 'Type',
      'Normal': 'Normal',
      'Child': 'Child',
      'Widowed': 'Widowed',
      'Divorced': 'Divorced',
      'Sick': 'Sick',
      'ID Copy': 'ID Copy',
      'Scan ID': 'Scan ID',
      'Gender': 'Gender',
      'Male': 'Male',
      'Female': 'Female',
      'Name': 'Name',
      'ID Number': 'ID Number',
      'Mobile Number': 'Mobile Number',
      'Entity': 'Entity',
      'Number of Units': 'Number of Units',
      'NFC Preprinted Code': 'NFC Preprinted Code',
      'Photo': 'Photo',
      'Photo (Optional)': 'Photo (Optional)',
      'Take Photo': 'Take Photo',
      'Select Photo': 'Select Photo',
      'Register': 'Register',
      'Update': 'Update',
      'Beneficiary registered successfully': 'Beneficiary registered successfully',
      'Beneficiary updated successfully': 'Beneficiary updated successfully',
      // Distribution Area
      'Add Distribution Area': 'Add Distribution Area',
      'Distribution Area Name': 'Distribution Area Name',
      'Enter distribution area name': 'Enter distribution area name',
      'Create Area': 'Create Area',
      'Area created successfully': 'Area created successfully',
      // Common Messages
      'Please select a distribution area': 'Please select a distribution area',
      'Please select an initial assigned queue point': 'Please select an initial assigned queue point',
      'Please enter entity name': 'Please enter entity name',
      'Please select an entity': 'Please select an entity',
      'Please enter number of units': 'Please enter number of units',
      'ID scanned successfully': 'ID scanned successfully',
      'Name extracted from ID': 'Name extracted from ID',
      'Please scan ID first': 'Please scan ID first',
      'This ID is already registered': 'This ID is already registered',
      'Are you sure you want to delete this queue?': 'Are you sure you want to delete this queue?',
      'Yes': 'Yes',
      'No': 'No',
      'Queue deleted successfully': 'Queue deleted successfully',
      'Are you sure you want to logout?': 'Are you sure you want to logout?',
      'Receive push notifications': 'Receive push notifications',
      'Switch to dark theme': 'Switch to dark theme',
      'Select': 'Select',
      'Select previous field first': 'Select previous field first',
      'Enter full name': 'Enter full name',
      'Enter mobile number': 'Enter mobile number',
      'Enter email (optional)': 'Enter email (optional)',
      'Enter notes (optional)': 'Enter notes (optional)',
      'Enter notes': 'Enter notes',
      'Enter reference': 'Enter reference',
      'Volunteer added successfully': 'Volunteer added successfully',
      'Full Name': 'Full Name',
      'Email': 'Email',
      'Notes': 'Notes',
      'Reference (Optional)': 'Reference (Optional)',
      'Country': 'Country',
      'Governorate': 'Governorate',
      'City': 'City',
      'Distribution Point': 'Distribution Point',
      'Distribution Area': 'Distribution Area',
      'Other': 'Other',
      'Enter custom entity name': 'Enter custom entity name',
      'Select entity': 'Select entity',
      'App Statistics': 'App Statistics',
      'Our Queue List': 'Our Queue List',
      'Queue Point': 'Queue Point',
      'Date Range': 'Date Range',
      'Time Range': 'Time Range',
      'Available Units': 'Available Units',
      'Estimated Size': 'Estimated Size',
      'Serving Options': 'Serving Options',
      'Grace 5': 'Grace 5',
      'Grace 10': 'Grace 10',
      'No Order for serving': 'No Order for serving',
      'Serving without tickets': 'Serving without tickets',
      'Eligible for': 'Eligible for',
      'meals': 'meals',
      'Already taken': 'Already taken',
      'Mark as Served': 'Mark as Served',
      'Total Attendees': 'Total Attendees',
      'Current Queue Number': 'Current Queue Number',
      'Ticket Number': 'Ticket Number',
      'Verify Beneficiary': 'Verify Beneficiary',
      'Search by': 'Search by',
      'Enter ID number': 'Enter ID number',
      'Enter mobile number': 'Enter mobile number',
      'Scan NFC': 'Scan NFC',
      'Verify': 'Verify',
      'Send OTP': 'Send OTP',
      'Verified': 'Verified',
      'Enter OTP': 'Enter OTP',
      'Mobile number verified': 'Mobile number verified',
      'Please verify mobile number with OTP first': 'Please verify mobile number with OTP first',
      'Please enter a valid Egyptian mobile number': 'Please enter a valid Egyptian mobile number',
      'OTP sent to': 'OTP sent to',
      'OTP verified successfully': 'OTP verified successfully',
      'Invalid OTP. Please try again': 'Invalid OTP. Please try again',
      'Admin request submitted successfully. Waiting for approval.': 'Admin request submitted successfully. Waiting for approval.',
      'Registration successful! You can now login to access your queue number.': 'Registration successful! You can now login to access your queue number.',
      'Required': 'Required',
      'Invalid Egyptian mobile number': 'Invalid Egyptian mobile number',
      'Please select governorate and city': 'Please select governorate and city',
      'Please select or create a queue point': 'Please select or create a queue point',
      'Please enter queue point name': 'Please enter queue point name',
      'Please select date and time ranges': 'Please select date and time ranges',
      'Please enter unit name': 'Please enter unit name',
      'Queue Point Name': 'Queue Point Name',
      'Queue Point Description': 'Queue Point Description',
      'Q Point (Distribution Point)': 'Q Point (Distribution Point)',
      'Create Admin': 'Create Admin',
      'Admin Requests': 'Admin Requests',
      'Approve': 'Approve',
      'Reject': 'Reject',
      'Request Admin Account': 'Request Admin Account',
      'Fill in your information to request admin access': 'Fill in your information to request admin access',
      'Admin request approved': 'Admin request approved',
      'Admin request rejected': 'Admin request rejected',
      'Admin created successfully': 'Admin created successfully',
      'Unknown screen': 'Unknown screen',
      'No queues yet. Add a new queue to get started.': 'No queues yet. Add a new queue to get started.',
      'Delete Queue': 'Delete Queue',
      'Enter name or extract from ID': 'Enter name or extract from ID',
      'Enter ID number': 'Enter ID number',
      'Enter custom number of units': 'Enter custom number of units',
      'Custom': 'Custom',
      'Enter queue name': 'Enter queue name',
      'Please enter queue name': 'Please enter queue name',
      'Allow serving without requiring a ticket number': 'Allow serving without requiring a ticket number',
      'Custom Unit Name *': 'Custom Unit Name *',
    },
    'Arabic': {
      // Common
      'Settings': 'الإعدادات',
      'Profile': 'الملف الشخصي',
      'Logout': 'تسجيل الخروج',
      'Dashboard': 'لوحة التحكم',
      'Reports': 'التقارير',
      'Admin Management': 'إدارة المسؤولين',
      'Add Volunteer': 'إضافة متطوع',
      'Preferences': 'التفضيلات',
      'Language': 'اللغة',
      'Enable Notifications': 'تفعيل الإشعارات',
      'Dark Mode': 'الوضع الداكن',
      'About': 'حول',
      'App Version': 'إصدار التطبيق',
      'Terms & Conditions': 'الشروط والأحكام',
      'Privacy Policy': 'سياسة الخصوصية',
      'Select Language': 'اختر اللغة',
      'English': 'الإنجليزية',
      'Arabic': 'العربية',
      'EQMS Dashboard': 'لوحة تحكم نظام إدارة الجودة الإلكتروني',
      'Total Queues': 'إجمالي الطوابير',
      'Active Queues': 'الطوابير النشطة',
      'Total Beneficiaries': 'إجمالي المستفيدين',
      'Served Beneficiaries': 'المستفيدون المخدومون',
      'Statistics Overview': 'نظرة عامة على الإحصائيات',
      'Queue Details': 'تفاصيل الطابور',
      'Status': 'الحالة',
      'units': 'وحدات',
      'Add Queue': 'إضافة طابور',
      'Add Beneficiary': 'إضافة مستفيد',
      'Beneficiaries': 'المستفيدون',
      'Add Area': 'إضافة منطقة',
      'Issue Queue Number': 'إصدار رقم الطابور',
      'Login': 'تسجيل الدخول',
      'Register': 'تسجيل',
      'Cancel': 'إلغاء',
      'Save': 'حفظ',
      'Delete': 'حذف',
      'Edit': 'تعديل',
      'View': 'عرض',
      'Start': 'بدء',
      'Suspend': 'تعليق',
      'Complete': 'إكمال',
      'Resume': 'استئناف',
      // Login & Auth
      'Sign In': 'تسجيل الدخول',
      'Continue as Guest': 'المتابعة كضيف',
      'Mobile Number': 'رقم الجوال',
      'Password': 'كلمة المرور',
      'Enter mobile number': 'أدخل رقم الجوال',
      'Enter password': 'أدخل كلمة المرور',
      'Please enter your mobile number': 'يرجى إدخال رقم جوالك',
      'Please enter your password': 'يرجى إدخال كلمة المرور',
      'Enter your mobile number': 'أدخل رقم جوالك',
      'Enter your password': 'أدخل كلمة المرور',
      'OR': 'أو',
      // Guest Mode
      'Guest Mode': 'وضع الضيف',
      'Welcome Guest': 'مرحباً بالضيف',
      'Register yourself as a beneficiary': 'سجل نفسك كمستفيد',
      'Register as Beneficiary': 'التسجيل كمستفيد',
      'Request Admin Account': 'طلب حساب مسؤول',
      // Queue Management
      'Queue Name': 'اسم الطابور',
      'Queue Manager': 'مدير الطابور',
      'Queue Type': 'نوع الطابور',
      'Single Day': 'يوم واحد',
      'Multi Day': 'أيام متعددة',
      'From Date': 'من تاريخ',
      'To Date': 'إلى تاريخ',
      'From Time': 'من وقت',
      'To Time': 'إلى وقت',
      'Select Date': 'اختر التاريخ',
      'Select Time': 'اختر الوقت',
      'Unit Name': 'اسم الوحدة',
      'Meals': 'وجبات',
      'Bags': 'أكياس',
      'Blankets': 'بطانيات',
      'Others': 'أخرى',
      'Custom Unit Name': 'اسم الوحدة المخصص',
      'Number of Available Units': 'عدد الوحدات المتاحة',
      'Estimated Queue Size': 'الحجم المقدر للطابور',
      'Direct Serve Option': 'خيار الخدمة المباشرة',
      'Priority': 'الأولوية',
      'Female': 'أنثى',
      'Elderly': 'مسن',
      'Disability': 'إعاقة',
      'Create Queue': 'إنشاء طابور',
      'Update Queue': 'تحديث الطابور',
      'Queue created successfully': 'تم إنشاء الطابور بنجاح',
      'Queue updated successfully': 'تم تحديث الطابور بنجاح',
      // Beneficiary
      'Beneficiary Registration': 'تسجيل المستفيد',
      'Self Registration': 'التسجيل الذاتي',
      'Initial Assigned Queue Point': 'نقطة الطابور المخصصة الأولية',
      'Type': 'النوع',
      'Normal': 'عادي',
      'Child': 'طفل',
      'Widowed': 'أرمل',
      'Divorced': 'مطلق',
      'Sick': 'مريض',
      'ID Copy': 'نسخة الهوية',
      'Scan ID': 'مسح الهوية',
      'Gender': 'الجنس',
      'Male': 'ذكر',
      'Female': 'أنثى',
      'Name': 'الاسم',
      'ID Number': 'رقم الهوية',
      'Mobile Number': 'رقم الجوال',
      'Entity': 'الكيان',
      'Number of Units': 'عدد الوحدات',
      'NFC Preprinted Code': 'رمز NFC المطبوع مسبقاً',
      'Photo': 'الصورة',
      'Photo (Optional)': 'الصورة (اختياري)',
      'Take Photo': 'التقاط صورة',
      'Select Photo': 'اختر صورة',
      'Register': 'تسجيل',
      'Update': 'تحديث',
      'Beneficiary registered successfully': 'تم تسجيل المستفيد بنجاح',
      'Beneficiary updated successfully': 'تم تحديث المستفيد بنجاح',
      // Distribution Area
      'Add Distribution Area': 'إضافة منطقة توزيع',
      'Distribution Area Name': 'اسم منطقة التوزيع',
      'Enter distribution area name': 'أدخل اسم منطقة التوزيع',
      'Create Area': 'إنشاء منطقة',
      'Area created successfully': 'تم إنشاء المنطقة بنجاح',
      // Common Messages
      'Please select a distribution area': 'يرجى اختيار منطقة توزيع',
      'Please select an initial assigned queue point': 'يرجى اختيار نقطة طابور مخصصة أولية',
      'Please enter entity name': 'يرجى إدخال اسم الكيان',
      'Please select an entity': 'يرجى اختيار كيان',
      'Please enter number of units': 'يرجى إدخال عدد الوحدات',
      'ID scanned successfully': 'تم مسح الهوية بنجاح',
      'Name extracted from ID': 'تم استخراج الاسم من الهوية',
      'Please scan ID first': 'يرجى مسح الهوية أولاً',
      'This ID is already registered': 'هذه الهوية مسجلة بالفعل',
      'Are you sure you want to delete this queue?': 'هل أنت متأكد من حذف هذا الطابور؟',
      'Yes': 'نعم',
      'No': 'لا',
      'Queue deleted successfully': 'تم حذف الطابور بنجاح',
      'Are you sure you want to logout?': 'هل أنت متأكد من تسجيل الخروج؟',
      'Receive push notifications': 'تلقي الإشعارات',
      'Switch to dark theme': 'التبديل إلى الوضع الداكن',
      'Select': 'اختر',
      'Select previous field first': 'اختر الحقل السابق أولاً',
      'Enter full name': 'أدخل الاسم الكامل',
      'Enter mobile number': 'أدخل رقم الجوال',
      'Enter email (optional)': 'أدخل البريد الإلكتروني (اختياري)',
      'Enter notes (optional)': 'أدخل الملاحظات (اختياري)',
      'Enter notes': 'أدخل الملاحظات',
      'Enter reference': 'أدخل المرجع',
      'Volunteer added successfully': 'تم إضافة المتطوع بنجاح',
      'Full Name': 'الاسم الكامل',
      'Email': 'البريد الإلكتروني',
      'Notes': 'الملاحظات',
      'Reference (Optional)': 'المرجع (اختياري)',
      'Country': 'الدولة',
      'Governorate': 'المحافظة',
      'City': 'المدينة',
      'Distribution Point': 'نقطة التوزيع',
      'Distribution Area': 'منطقة التوزيع',
      'Other': 'أخرى',
      'Enter custom entity name': 'أدخل اسم الكيان المخصص',
      'Select entity': 'اختر الكيان',
      'App Statistics': 'إحصائيات التطبيق',
      'Our Queue List': 'قائمة طوابيرنا',
      'Queue Point': 'نقطة الطابور',
      'Date Range': 'نطاق التاريخ',
      'Time Range': 'نطاق الوقت',
      'Available Units': 'الوحدات المتاحة',
      'Estimated Size': 'الحجم المقدر',
      'Serving Options': 'خيارات الخدمة',
      'Grace 5': 'تساهل 5',
      'Grace 10': 'تساهل 10',
      'No Order for serving': 'لا يوجد ترتيب للخدمة',
      'Serving without tickets': 'الخدمة بدون تذاكر',
      'Eligible for': 'مؤهل لـ',
      'meals': 'وجبات',
      'Already taken': 'تم أخذه بالفعل',
      'Mark as Served': 'وضع علامة كمخدوم',
      'Total Attendees': 'إجمالي الحضور',
      'Current Queue Number': 'رقم الطابور الحالي',
      'Ticket Number': 'رقم التذكرة',
      'Verify Beneficiary': 'التحقق من المستفيد',
      'Search by': 'البحث عن طريق',
      'Enter ID number': 'أدخل رقم الهوية',
      'Enter mobile number': 'أدخل رقم الجوال',
      'Scan NFC': 'مسح NFC',
      'Verify': 'التحقق',
      'Send OTP': 'إرسال رمز التحقق',
      'Verified': 'تم التحقق',
      'Enter OTP': 'أدخل رمز التحقق',
      'Mobile number verified': 'تم التحقق من رقم الجوال',
      'Please verify mobile number with OTP first': 'يرجى التحقق من رقم الجوال برمز التحقق أولاً',
      'Please enter a valid Egyptian mobile number': 'يرجى إدخال رقم جوال مصري صحيح',
      'OTP sent to': 'تم إرسال رمز التحقق إلى',
      'OTP verified successfully': 'تم التحقق من رمز التحقق بنجاح',
      'Invalid OTP. Please try again': 'رمز تحقق غير صحيح. يرجى المحاولة مرة أخرى',
      'Admin request submitted successfully. Waiting for approval.': 'تم إرسال طلب المسؤول بنجاح. في انتظار الموافقة.',
      'Registration successful! You can now login to access your queue number.': 'تم التسجيل بنجاح! يمكنك الآن تسجيل الدخول للوصول إلى رقم الطابور الخاص بك.',
      'Required': 'مطلوب',
      'Invalid Egyptian mobile number': 'رقم جوال مصري غير صحيح',
      'Please select governorate and city': 'يرجى اختيار المحافظة والمدينة',
      'Please select or create a queue point': 'يرجى اختيار أو إنشاء نقطة طابور',
      'Please enter queue point name': 'يرجى إدخال اسم نقطة الطابور',
      'Please select date and time ranges': 'يرجى اختيار نطاقات التاريخ والوقت',
      'Please enter unit name': 'يرجى إدخال اسم الوحدة',
      'Queue Point Name': 'اسم نقطة الطابور',
      'Queue Point Description': 'وصف نقطة الطابور',
      'Q Point (Distribution Point)': 'نقطة الطابور (نقطة التوزيع)',
      'Create Admin': 'إنشاء مسؤول',
      'Admin Requests': 'طلبات المسؤولين',
      'Approve': 'موافقة',
      'Reject': 'رفض',
      'Request Admin Account': 'طلب حساب مسؤول',
      'Fill in your information to request admin access': 'املأ معلوماتك لطلب وصول المسؤول',
      'Admin request approved': 'تمت الموافقة على طلب المسؤول',
      'Admin request rejected': 'تم رفض طلب المسؤول',
      'Admin created successfully': 'تم إنشاء المسؤول بنجاح',
      'Unknown screen': 'شاشة غير معروفة',
      'No queues yet. Add a new queue to get started.': 'لا توجد طوابير بعد. أضف طابوراً جديداً للبدء.',
      'Delete Queue': 'حذف الطابور',
      'Enter name or extract from ID': 'أدخل الاسم أو استخرجه من الهوية',
      'Enter ID number': 'أدخل رقم الهوية',
      'Enter custom number of units': 'أدخل عدد الوحدات المخصص',
      'Custom': 'مخصص',
      'Enter queue name': 'أدخل اسم الطابور',
      'Please enter queue name': 'يرجى إدخال اسم الطابور',
      'Distribution Area *': 'منطقة التوزيع *',
      'Initial Assigned Queue Point *': 'نقطة الطابور المخصصة الأولية *',
      'ID Copy *': 'نسخة الهوية *',
      'Type *': 'النوع *',
      'Gender *': 'الجنس *',
      'Name *': 'الاسم *',
      'ID Number *': 'رقم الهوية *',
      'Mobile Number *': 'رقم الجوال *',
      'Number of Units *': 'عدد الوحدات *',
      'Queue Name *': 'اسم الطابور *',
      'Queue Type *': 'نوع الطابور *',
      'From Date *': 'من تاريخ *',
      'To Date *': 'إلى تاريخ *',
      'From Time *': 'من وقت *',
      'To Time *': 'إلى وقت *',
      'Unit Name *': 'اسم الوحدة *',
      'Number of Available Units *': 'عدد الوحدات المتاحة *',
      'Estimated Queue Size *': 'الحجم المقدر للطابور *',
      'Please enter queue name': 'يرجى إدخال اسم الطابور',
    },
  };
  
  static String translate(String key) {
    return translations[currentLanguage]?[key] ?? key;
  }
  
  static bool get isArabic => currentLanguage == 'Arabic';
  
  static TextDirection get textDirection => isArabic ? TextDirection.rtl : TextDirection.ltr;
  
  static void setLanguage(String language) {
    currentLanguage = language;
    languageNotifier.value = language;
  }
}

// Enum for image source (in real app, use image_picker package)
enum ImageSource { camera, gallery }

// Shared admin requests storage (in real app, this would be a database)
class AdminRequestStorage {
  static final List<Admin> _adminRequests = [];
  
  static List<Admin> get adminRequests => List.unmodifiable(_adminRequests);
  
  static void addRequest(Admin admin) {
    _adminRequests.add(admin);
  }
  
  static void removeRequest(String adminId) {
    _adminRequests.removeWhere((a) => a.id == adminId);
  }
  
  static void clear() {
    _adminRequests.clear();
  }
}

// Distribution Area Model
class DistributionArea {
  final String id;
  final String country;
  final String governorate;
  final String city;
  final String areaName;

  DistributionArea({
    required this.id,
    required this.country,
    required this.governorate,
    required this.city,
    required this.areaName,
  });

  String get fullName => '$country > $governorate > $city > $areaName';
}

// Admin Model
class Admin {
  final String id;
  final String country;
  final String governorate;
  final String city;
  final String distributionPoint;
  final String? distributionPointDescription;
  final String fullName;
  final String mobile;
  final String notes;
  final String? reference;
  final String status; // pending, active, banned
  final bool isRequestedByGuest;
  final DateTime createdAt;

  Admin({
    required this.id,
    required this.country,
    required this.governorate,
    required this.city,
    required this.distributionPoint,
    this.distributionPointDescription,
    required this.fullName,
    required this.mobile,
    required this.notes,
    this.reference,
    required this.status,
    required this.isRequestedByGuest,
    required this.createdAt,
  });

  Admin copyWith({
    String? id,
    String? country,
    String? governorate,
    String? city,
    String? distributionPoint,
    String? distributionPointDescription,
    String? fullName,
    String? mobile,
    String? notes,
    String? reference,
    String? status,
    bool? isRequestedByGuest,
    DateTime? createdAt,
  }) {
    return Admin(
      id: id ?? this.id,
      country: country ?? this.country,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      distributionPoint: distributionPoint ?? this.distributionPoint,
      distributionPointDescription: distributionPointDescription ?? this.distributionPointDescription,
      fullName: fullName ?? this.fullName,
      mobile: mobile ?? this.mobile,
      notes: notes ?? this.notes,
      reference: reference ?? this.reference,
      status: status ?? this.status,
      isRequestedByGuest: isRequestedByGuest ?? this.isRequestedByGuest,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// Queue Model
class Queue {
  final String name;
  final String queueManager;
  final String country;
  final String governorate;
  final String city;
  final String queuePointName;
  final String distributionArea;
  final String queueType;
  final DateTime fromDate;
  final DateTime toDate;
  final TimeOfDay fromTime;
  final TimeOfDay toTime;
  final String unitName;
  final int numberOfAvailableUnits;
  final int estimatedQueueSize;
  final bool directServe;
  final List<String> priority;
  final String status;
  final String? subtitle;
  final bool isStarted;
  final bool isCompleted;
  final bool isSuspended;

  Queue({
    required this.name,
    required this.queueManager,
    required this.country,
    required this.governorate,
    required this.city,
    required this.queuePointName,
    required this.distributionArea,
    required this.queueType,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.unitName,
    required this.numberOfAvailableUnits,
    required this.estimatedQueueSize,
    required this.directServe,
    required this.priority,
    required this.status,
    this.subtitle,
    this.isStarted = false,
    this.isCompleted = false,
    this.isSuspended = false,
  });

  Queue copyWith({
    String? name,
    String? queueManager,
    String? country,
    String? governorate,
    String? city,
    String? queuePointName,
    String? distributionArea,
    String? queueType,
    DateTime? fromDate,
    DateTime? toDate,
    TimeOfDay? fromTime,
    TimeOfDay? toTime,
    String? unitName,
    int? numberOfAvailableUnits,
    int? estimatedQueueSize,
    bool? directServe,
    List<String>? priority,
    String? status,
    String? subtitle,
    bool? isStarted,
    bool? isCompleted,
    bool? isSuspended,
  }) {
    return Queue(
      name: name ?? this.name,
      queueManager: queueManager ?? this.queueManager,
      country: country ?? this.country,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      queuePointName: queuePointName ?? this.queuePointName,
      distributionArea: distributionArea ?? this.distributionArea,
      queueType: queueType ?? this.queueType,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      unitName: unitName ?? this.unitName,
      numberOfAvailableUnits: numberOfAvailableUnits ?? this.numberOfAvailableUnits,
      estimatedQueueSize: estimatedQueueSize ?? this.estimatedQueueSize,
      directServe: directServe ?? this.directServe,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      subtitle: subtitle ?? this.subtitle,
      isStarted: isStarted ?? this.isStarted,
      isCompleted: isCompleted ?? this.isCompleted,
      isSuspended: isSuspended ?? this.isSuspended,
    );
  }

  String get queuePoint {
    return '$country > $governorate > $city > $queuePointName';
  }

  String get displayDateRange {
    return '${fromDate.day}/${fromDate.month}/${fromDate.year} - ${toDate.day}/${toDate.month}/${toDate.year}';
  }

  String get displayTimeRange {
    return '${fromTime.hour.toString().padLeft(2, '0')}:${fromTime.minute.toString().padLeft(2, '0')} - ${toTime.hour.toString().padLeft(2, '0')}:${toTime.minute.toString().padLeft(2, '0')}';
  }
}

// Beneficiary Model
class Beneficiary {
  final String id;
  final String distributionArea;
  final String initialAssignedQueuePoint;
  final String type;
  final String? idCopyPath;
  final String gender;
  final String name;
  final String idNumber;
  final String? mobileNumber;
  final bool isEntity;
  final String? entityName;
  final String numberOfUnits;
  final String? nfcPreprintedCode;
  final String? photoPath;
  final String status;
  final DateTime? birthDate;
  final int? queueNumber;
  final bool isServed;
  final int unitsTaken;

  Beneficiary({
    required this.id,
    required this.distributionArea,
    required this.initialAssignedQueuePoint,
    required this.type,
    this.idCopyPath,
    required this.gender,
    required this.name,
    required this.idNumber,
    this.mobileNumber,
    required this.isEntity,
    this.entityName,
    required this.numberOfUnits,
    this.nfcPreprintedCode,
    this.photoPath,
    required this.status,
    this.birthDate,
    this.queueNumber,
    this.isServed = false,
    this.unitsTaken = 0,
  });

  Beneficiary copyWith({
    String? id,
    String? distributionArea,
    String? initialAssignedQueuePoint,
    String? type,
    String? idCopyPath,
    String? gender,
    String? name,
    String? idNumber,
    String? mobileNumber,
    bool? isEntity,
    String? entityName,
    String? numberOfUnits,
    String? nfcPreprintedCode,
    String? photoPath,
    String? status,
    DateTime? birthDate,
    int? queueNumber,
    bool? isServed,
    int? unitsTaken,
  }) {
    return Beneficiary(
      id: id ?? this.id,
      distributionArea: distributionArea ?? this.distributionArea,
      initialAssignedQueuePoint: initialAssignedQueuePoint ?? this.initialAssignedQueuePoint,
      type: type ?? this.type,
      idCopyPath: idCopyPath ?? this.idCopyPath,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      idNumber: idNumber ?? this.idNumber,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isEntity: isEntity ?? this.isEntity,
      entityName: entityName ?? this.entityName,
      numberOfUnits: numberOfUnits ?? this.numberOfUnits,
      nfcPreprintedCode: nfcPreprintedCode ?? this.nfcPreprintedCode,
      photoPath: photoPath ?? this.photoPath,
      status: status ?? this.status,
      birthDate: birthDate ?? this.birthDate,
      queueNumber: queueNumber ?? this.queueNumber,
      isServed: isServed ?? this.isServed,
      unitsTaken: unitsTaken ?? this.unitsTaken,
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: AppLanguage.languageNotifier,
      builder: (context, language, child) {
        return MaterialApp(
          title: 'EQMS App',
          debugShowCheckedModeBanner: false,
          locale: AppLanguage.isArabic ? const Locale('ar', 'SA') : const Locale('en', 'US'),
          builder: (context, child) {
            return Directionality(
              textDirection: AppLanguage.textDirection,
              child: child!,
            );
          },
          theme: ThemeData(
            primarySwatch: Colors.teal,
            primaryColor: const Color(0xFF00BFA5),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF00BFA5),
              foregroundColor: Colors.white,
            ),
          ),
          home: const LoginScreen(),
        );
      },
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    final _mobileController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE8F5E9), Colors.white],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 48),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: AppLanguage.translate('Mobile Number'),
                        hintText: AppLanguage.translate('Enter mobile number'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: tealGreen, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.phone, color: tealGreen),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLanguage.translate('Please enter your mobile number');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: AppLanguage.translate('Password'),
                        hintText: AppLanguage.translate('Enter password'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: tealGreen, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock, color: tealGreen),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLanguage.translate('Please enter your password');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          AppLanguage.translate('Sign In'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            AppLanguage.translate('OR'),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey[300],
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const GuestDashboardScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: tealGreen,
                          side: const BorderSide(color: tealGreen, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          AppLanguage.translate('Continue as Guest'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Guest Dashboard Screen
class GuestDashboardScreen extends StatefulWidget {
  const GuestDashboardScreen({super.key});

  @override
  State<GuestDashboardScreen> createState() => _GuestDashboardScreenState();
}

class _GuestDashboardScreenState extends State<GuestDashboardScreen> {
  final List<Beneficiary> _beneficiaries = [];
  late final List<Queue> _queues;
  late final List<DistributionArea> _distributionAreas;
  final List<String> _entities = [
    'Red Crescent',
    'Ministry of Social Solidarity',
    'Local Charity Organization',
    'Community Center',
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    // Load the same predefined data as main dashboard
    _distributionAreas = [
      DistributionArea(
        id: '1',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Nasr City',
        areaName: 'Nasr City distribution area',
      ),
      DistributionArea(
        id: '2',
        country: 'Egypt',
        governorate: 'Alexandria',
        city: 'Alexandria',
        areaName: 'Alexandria distribution area',
      ),
      DistributionArea(
        id: '3',
        country: 'Egypt',
        governorate: 'Giza',
        city: 'Giza',
        areaName: 'Giza distribution area',
      ),
      DistributionArea(
        id: '4',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Heliopolis',
        areaName: 'Heliopolis distribution area',
      ),
      DistributionArea(
        id: '5',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Maadi',
        areaName: 'Maadi distribution area',
      ),
    ];

    _queues = [
      Queue(
        name: 'Morning Meals Queue - Nasr City',
        queueManager: 'Admin User',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Nasr City',
        queuePointName: 'Nasr City distribution area',
        distributionArea: '1',
        queueType: 'Single Day',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(const Duration(days: 7)),
        fromTime: const TimeOfDay(hour: 8, minute: 0),
        toTime: const TimeOfDay(hour: 12, minute: 0),
        unitName: 'Meals',
        numberOfAvailableUnits: 500,
        estimatedQueueSize: 450,
        directServe: false,
        priority: ['Elderly', 'Disability'],
        status: 'active',
      ),
      Queue(
        name: 'Evening Meals Queue - Alexandria',
        queueManager: 'Admin User',
        country: 'Egypt',
        governorate: 'Alexandria',
        city: 'Alexandria',
        queuePointName: 'Alexandria distribution area',
        distributionArea: '2',
        queueType: 'Multi Day',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(const Duration(days: 14)),
        fromTime: const TimeOfDay(hour: 16, minute: 0),
        toTime: const TimeOfDay(hour: 20, minute: 0),
        unitName: 'Meals',
        numberOfAvailableUnits: 300,
        estimatedQueueSize: 280,
        directServe: true,
        priority: ['Female'],
        status: 'active',
      ),
      Queue(
        name: 'Food Bags Distribution - Giza',
        queueManager: 'Admin User',
        country: 'Egypt',
        governorate: 'Giza',
        city: 'Giza',
        queuePointName: 'Giza distribution area',
        distributionArea: '3',
        queueType: 'Single Day',
        fromDate: DateTime.now().add(const Duration(days: 1)),
        toDate: DateTime.now().add(const Duration(days: 8)),
        fromTime: const TimeOfDay(hour: 10, minute: 0),
        toTime: const TimeOfDay(hour: 14, minute: 0),
        unitName: 'Bags',
        numberOfAvailableUnits: 200,
        estimatedQueueSize: 180,
        directServe: false,
        priority: [],
        status: 'active',
      ),
      Queue(
        name: 'Weekly Meals - Heliopolis',
        queueManager: 'Admin User',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Heliopolis',
        queuePointName: 'Heliopolis distribution area',
        distributionArea: '4',
        queueType: 'Multi Day',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(const Duration(days: 30)),
        fromTime: const TimeOfDay(hour: 9, minute: 0),
        toTime: const TimeOfDay(hour: 15, minute: 0),
        unitName: 'Meals',
        numberOfAvailableUnits: 400,
        estimatedQueueSize: 350,
        directServe: false,
        priority: ['Elderly'],
        status: 'active',
      ),
      Queue(
        name: 'Emergency Relief - Maadi',
        queueManager: 'Admin User',
        country: 'Egypt',
        governorate: 'Cairo',
        city: 'Maadi',
        queuePointName: 'Maadi distribution area',
        distributionArea: '5',
        queueType: 'Single Day',
        fromDate: DateTime.now(),
        toDate: DateTime.now().add(const Duration(days: 5)),
        fromTime: const TimeOfDay(hour: 11, minute: 0),
        toTime: const TimeOfDay(hour: 17, minute: 0),
        unitName: 'Blankets',
        numberOfAvailableUnits: 150,
        estimatedQueueSize: 120,
        directServe: true,
        priority: ['Disability', 'Sick'],
        status: 'active',
      ),
    ];
  }

  void _addBeneficiary(Beneficiary beneficiary) {
    setState(() {
      _beneficiaries.add(beneficiary);
    });
  }

  void _addEntity(String entity) {
    setState(() {
      if (!_entities.contains(entity)) {
        _entities.add(entity);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.translate('Guest Mode')),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              AppLanguage.translate('Login'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Color(0xFF00BFA5),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome Guest',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Register yourself as a beneficiary',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GuestBeneficiaryRegistrationScreen(
                            queues: _queues,
                            beneficiaries: _beneficiaries,
                            distributionAreas: _distributionAreas,
                            entities: _entities,
                            onBeneficiaryCreated: (beneficiary) {
                              _addBeneficiary(beneficiary);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLanguage.translate('Registration successful! You can now login to access your queue number.'))),
                              );
                            },
                            onEntityAdded: _addEntity,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Register as Beneficiary'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RequestAdminAccountScreen(
                            distributionAreas: _distributionAreas,
                            onRequestSubmitted: (admin) {
                              // Save the admin request to shared storage
                              AdminRequestStorage.addRequest(admin);
                            },
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.admin_panel_settings),
                    label: Text(AppLanguage.translate('Request Admin Account')),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00BFA5),
                      side: const BorderSide(color: Color(0xFF00BFA5), width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Guest Beneficiary Registration Screen (without NFC requirement)
class GuestBeneficiaryRegistrationScreen extends StatefulWidget {
  final List<Queue> queues;
  final List<Beneficiary> beneficiaries;
  final List<DistributionArea> distributionAreas;
  final List<String> entities;
  final Function(Beneficiary) onBeneficiaryCreated;
  final Function(String) onEntityAdded;

  const GuestBeneficiaryRegistrationScreen({
    super.key,
    required this.queues,
    required this.beneficiaries,
    required this.distributionAreas,
    required this.entities,
    required this.onBeneficiaryCreated,
    required this.onEntityAdded,
  });

  @override
  State<GuestBeneficiaryRegistrationScreen> createState() => _GuestBeneficiaryRegistrationScreenState();
}

class _GuestBeneficiaryRegistrationScreenState extends State<GuestBeneficiaryRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _customEntityController = TextEditingController();
  final _customUnitsController = TextEditingController();

  String? _selectedDistributionArea;
  String? _selectedQueuePoint;
  String _type = 'Normal';
  String _gender = 'Male';
  String _status = 'Active';
  String _numberOfUnits = '1';
  bool _isEntity = false;
  String? _selectedEntity;
  bool _useCustomUnits = false;
  bool _useCustomEntity = false;
  String? _idCopyPath;
  String? _photoPath;
  DateTime? _extractedBirthDate;
  String? _duplicateIDMessage;

  final List<String> _typeOptions = ['Normal', 'Child', 'Widowed', 'Divorced', 'Disability', 'Sick', 'Elderly'];
  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _statusOptions = ['Active', 'Banned'];
  final List<String> _unitsOptions = ['1', '2'];

  List<Queue> get _filteredQueues {
    if (_selectedDistributionArea == null) return [];
    return widget.queues.where((q) => q.distributionArea == _selectedDistributionArea).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _mobileNumberController.dispose();
    _customEntityController.dispose();
    _customUnitsController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDistributionArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select a distribution area'))),
        );
        return;
      }
      if (_selectedQueuePoint == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select an initial assigned queue point'))),
        );
        return;
      }

      String entityName = '';
      if (_isEntity) {
        if (_useCustomEntity) {
          if (_customEntityController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Please enter entity name'))),
            );
            return;
          }
          entityName = _customEntityController.text;
          widget.onEntityAdded(entityName);
        } else {
          if (_selectedEntity == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Please select an entity'))),
            );
            return;
          }
          entityName = _selectedEntity!;
        }
      }

      String units = _numberOfUnits;
      if (_useCustomUnits) {
        if (_customUnitsController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLanguage.translate('Please enter number of units'))),
          );
          return;
        }
        units = _customUnitsController.text;
      }

      final beneficiary = Beneficiary(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        distributionArea: _selectedDistributionArea!,
        initialAssignedQueuePoint: _selectedQueuePoint!,
        type: _type,
        idCopyPath: _idCopyPath,
        gender: _gender,
        name: _nameController.text,
        idNumber: _idNumberController.text,
        mobileNumber: _mobileNumberController.text.isNotEmpty ? _mobileNumberController.text : null,
        isEntity: _isEntity,
        entityName: _isEntity ? entityName : null,
        numberOfUnits: units,
        nfcPreprintedCode: null, // NFC not required for guests
        photoPath: _photoPath,
        status: _status,
        birthDate: _extractedBirthDate,
      );

      widget.onBeneficiaryCreated(beneficiary);
      // Navigation is handled by the callback in GuestDashboardScreen
    }
  }

  Future<void> _scanID() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final simulatedBirthDate = DateTime(1965, 1, 1);
    
    setState(() {
      _idCopyPath = 'scanned_id_${DateTime.now().millisecondsSinceEpoch}.jpg';
      _extractedBirthDate = simulatedBirthDate;
      
      if (simulatedBirthDate.year < 1970 && _type == 'Normal') {
        _type = 'Elderly';
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLanguage.translate('ID scanned successfully'))),
    );
  }

  Future<void> _extractNameFromID() async {
    if (_idCopyPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLanguage.translate('Please scan ID first'))),
      );
      return;
    }
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _nameController.text = 'Extracted Name from ID';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLanguage.translate('Name extracted from ID'))),
    );
  }

  void _checkDuplicateID(String idNumber) {
    try {
      final existingBeneficiary = widget.beneficiaries.firstWhere(
        (b) => b.idNumber == idNumber,
      );
      
      setState(() {
        _duplicateIDMessage = 'This ID is already registered. Initial assigned queue: ${existingBeneficiary.initialAssignedQueuePoint}';
      });
    } catch (e) {
      setState(() {
        _duplicateIDMessage = null;
      });
    }
  }

  Future<void> _takePhoto() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Photo Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _photoPath = 'beneficiary_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Photo ${source == ImageSource.camera ? 'taken' : 'selected'} successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1A237E);
    const tealGreen = Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Registration'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLanguage.translate('Register as Beneficiary'),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppLanguage.translate('Fill in your information to register'),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Distribution Area *'),
                const SizedBox(height: 8),
                _buildDistributionAreaDropdown(),
                const SizedBox(height: 24),
                _buildLabel('Initial Assigned Queue Point *'),
                const SizedBox(height: 8),
                _buildQueueDropdown(),
                const SizedBox(height: 24),
                _buildLabel('ID Copy *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _scanID,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(_idCopyPath != null ? AppLanguage.translate('ID Scanned') : AppLanguage.translate('Scan ID')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _idCopyPath != null ? Colors.green : tealGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    if (_idCopyPath != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('Type *'),
                const SizedBox(height: 8),
                _buildDropdown(_type, _typeOptions, (value) => setState(() => _type = value ?? 'Normal')),
                const SizedBox(height: 24),
                _buildLabel('Gender *'),
                const SizedBox(height: 8),
                _buildDropdown(_gender, _genderOptions, (value) => setState(() => _gender = value ?? 'Male')),
                const SizedBox(height: 24),
                _buildLabel('Name *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration('Enter name or extract from ID'),
                        validator: (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter name') : null,
                      ),
                    ),
                    if (_idCopyPath != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.auto_fix_high),
                        tooltip: 'Extract name from ID using OCR',
                        onPressed: _extractNameFromID,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('ID Number *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _idNumberController,
                  decoration: _buildInputDecoration('Enter ID number'),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter ID number' : null,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _checkDuplicateID(value);
                    }
                  },
                ),
                if (_duplicateIDMessage != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _duplicateIDMessage!,
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildLabel('Mobile Number *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration('Enter mobile number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid Egyptian mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildLabel('Number of Units *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        _numberOfUnits,
                        _unitsOptions,
                        (value) => setState(() {
                          _numberOfUnits = value ?? '1';
                          _useCustomUnits = false;
                        }),
                      ),
                    ),
                    Checkbox(
                      value: _useCustomUnits,
                      onChanged: (value) => setState(() => _useCustomUnits = value ?? false),
                    ),
                    const Text('Custom'),
                  ],
                ),
                if (_useCustomUnits) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _customUnitsController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration('Enter custom number of units'),
                  ),
                ],
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: const Text('Entity'),
                  value: _isEntity,
                  onChanged: (value) => setState(() => _isEntity = value ?? false),
                ),
                if (_isEntity) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedEntity,
                              isExpanded: true,
                              hint: const Text('Select entity'),
                              items: [...widget.entities, 'Other'].map((entity) {
                                return DropdownMenuItem(
                                  value: entity,
                                  child: Text(
                                    entity,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) => setState(() {
                                _selectedEntity = value;
                                _useCustomEntity = value == 'Other';
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_useCustomEntity) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _customEntityController,
                      decoration: _buildInputDecoration('Enter custom entity name'),
                    ),
                  ],
                ],
                const SizedBox(height: 24),
                _buildLabel('Photo (Optional)'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (_photoPath != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          color: Colors.grey[200],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 20, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _photoPath = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.person, size: 40, color: Colors.grey),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(_photoPath != null ? 'Retake Photo' : 'Take Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      AppLanguage.translate(text),
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A237E)),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: AppLanguage.translate(hint),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDistributionAreaDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDistributionArea,
          isExpanded: true,
          hint: const Text('Select distribution area'),
          items: widget.distributionAreas.map((area) {
            return DropdownMenuItem(
              value: area.id,
              child: Text(
                area.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return widget.distributionAreas.map((area) {
              return Text(
                area.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            }).toList();
          },
          onChanged: (value) {
            setState(() {
              _selectedDistributionArea = value;
              _selectedQueuePoint = null;
            });
          },
        ),
      ),
    );
  }

  Widget _buildQueueDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedQueuePoint,
          isExpanded: true,
          hint: Text(_selectedDistributionArea == null ? 'Select distribution area first' : 'Select queue point'),
          items: _filteredQueues.map((queue) {
            return DropdownMenuItem(value: queue.name, child: Text(queue.name));
          }).toList(),
          onChanged: _selectedDistributionArea == null ? null : (value) => setState(() => _selectedQueuePoint = value),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final bool isGuest;
  
  const DashboardScreen({super.key, this.isGuest = false});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  
  final List<Admin> _admins = [];
  
  List<Admin> get _adminRequests => AdminRequestStorage.adminRequests;
  
  final List<String> _entities = [
    'Red Crescent',
    'Ministry of Social Solidarity',
    'Local Charity Organization',
    'Community Center',
  ];
  
  final List<DistributionArea> _distributionAreas = [
    DistributionArea(
      id: '1',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Nasr City',
      areaName: 'Nasr City distribution area',
    ),
    DistributionArea(
      id: '2',
      country: 'Egypt',
      governorate: 'Alexandria',
      city: 'Alexandria',
      areaName: 'Alexandria distribution area',
    ),
    DistributionArea(
      id: '3',
      country: 'Egypt',
      governorate: 'Giza',
      city: 'Giza',
      areaName: 'Giza distribution area',
    ),
    DistributionArea(
      id: '4',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Heliopolis',
      areaName: 'Heliopolis distribution area',
    ),
    DistributionArea(
      id: '5',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Maadi',
      areaName: 'Maadi distribution area',
    ),
  ];
  
  final List<Queue> _queues = [
    Queue(
      name: 'Morning Meals Queue - Nasr City',
      queueManager: 'Admin User',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Nasr City',
      queuePointName: 'Nasr City distribution area',
      distributionArea: '1',
      queueType: 'Single Day',
      fromDate: DateTime.now(),
      toDate: DateTime.now().add(const Duration(days: 7)),
      fromTime: const TimeOfDay(hour: 8, minute: 0),
      toTime: const TimeOfDay(hour: 12, minute: 0),
      unitName: 'Meals',
      numberOfAvailableUnits: 500,
      estimatedQueueSize: 450,
      directServe: false,
      priority: ['Elderly', 'Disability'],
      status: 'active',
    ),
    Queue(
      name: 'Evening Meals Queue - Alexandria',
      queueManager: 'Admin User',
      country: 'Egypt',
      governorate: 'Alexandria',
      city: 'Alexandria',
      queuePointName: 'Alexandria distribution area',
      distributionArea: '2',
      queueType: 'Multi Day',
      fromDate: DateTime.now(),
      toDate: DateTime.now().add(const Duration(days: 14)),
      fromTime: const TimeOfDay(hour: 16, minute: 0),
      toTime: const TimeOfDay(hour: 20, minute: 0),
      unitName: 'Meals',
      numberOfAvailableUnits: 300,
      estimatedQueueSize: 280,
      directServe: true,
      priority: ['Female'],
      status: 'active',
    ),
    Queue(
      name: 'Food Bags Distribution - Giza',
      queueManager: 'Admin User',
      country: 'Egypt',
      governorate: 'Giza',
      city: 'Giza',
      queuePointName: 'Giza distribution area',
      distributionArea: '3',
      queueType: 'Single Day',
      fromDate: DateTime.now().add(const Duration(days: 1)),
      toDate: DateTime.now().add(const Duration(days: 8)),
      fromTime: const TimeOfDay(hour: 10, minute: 0),
      toTime: const TimeOfDay(hour: 14, minute: 0),
      unitName: 'Bags',
      numberOfAvailableUnits: 200,
      estimatedQueueSize: 180,
      directServe: false,
      priority: [],
      status: 'active',
    ),
    Queue(
      name: 'Weekly Meals - Heliopolis',
      queueManager: 'Admin User',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Heliopolis',
      queuePointName: 'Heliopolis distribution area',
      distributionArea: '4',
      queueType: 'Multi Day',
      fromDate: DateTime.now(),
      toDate: DateTime.now().add(const Duration(days: 30)),
      fromTime: const TimeOfDay(hour: 9, minute: 0),
      toTime: const TimeOfDay(hour: 15, minute: 0),
      unitName: 'Meals',
      numberOfAvailableUnits: 400,
      estimatedQueueSize: 350,
      directServe: false,
      priority: ['Elderly'],
      status: 'active',
    ),
    Queue(
      name: 'Emergency Relief - Maadi',
      queueManager: 'Admin User',
      country: 'Egypt',
      governorate: 'Cairo',
      city: 'Maadi',
      queuePointName: 'Maadi distribution area',
      distributionArea: '5',
      queueType: 'Single Day',
      fromDate: DateTime.now(),
      toDate: DateTime.now().add(const Duration(days: 5)),
      fromTime: const TimeOfDay(hour: 11, minute: 0),
      toTime: const TimeOfDay(hour: 17, minute: 0),
      unitName: 'Blankets',
      numberOfAvailableUnits: 150,
      estimatedQueueSize: 120,
      directServe: true,
      priority: ['Disability', 'Sick'],
      status: 'active',
    ),
  ];

  late final List<Beneficiary> _beneficiaries = _initializeBeneficiaries();

  List<Beneficiary> _initializeBeneficiaries() {
    final types = ['Normal', 'Child', 'Widowed', 'Divorced', 'Disability', 'Sick', 'Elderly'];
    final genders = ['Male', 'Female'];
    final statuses = ['Active', 'Banned'];
    final units = ['1', '2', '3', '4', '5'];
    
    return List.generate(100, (index) {
      final queueIndex = index % 5;
      final queue = _queues[queueIndex];
      
      return Beneficiary(
        id: 'ben_${index + 1}',
        distributionArea: queue.distributionArea,
        initialAssignedQueuePoint: queue.name,
        type: types[index % types.length],
        gender: genders[index % genders.length],
        name: 'Beneficiary ${index + 1}',
        idNumber: '${29000000000 + index}',
        mobileNumber: '01${(index % 10)}${(index % 100).toString().padLeft(8, '0')}',
        isEntity: index % 10 == 0,
        entityName: index % 10 == 0 ? _entities[index % _entities.length] : null,
        numberOfUnits: units[index % units.length],
        nfcPreprintedCode: index % 5 == 0 ? 'NFC_${index + 1}' : null,
        status: statuses[index % statuses.length],
        birthDate: DateTime(1950 + (index % 70), 1 + (index % 12), 1 + (index % 28)),
        queueNumber: index + 1,
        isServed: index % 3 == 0,
        unitsTaken: index % 3 == 0 ? (index % 3) + 1 : 0,
      );
    });
  }

  void _addQueue(Queue queue) {
    setState(() {
      _queues.add(queue);
    });
  }

  void _updateQueue(int index, Queue queue) {
    setState(() {
      _queues[index] = queue;
    });
  }

  void _deleteQueue(int index) {
    setState(() {
      _queues.removeAt(index);
    });
  }

  void _addBeneficiary(Beneficiary beneficiary) {
    setState(() {
      _beneficiaries.add(beneficiary);
    });
  }

  void _updateBeneficiary(int index, Beneficiary beneficiary) {
    setState(() {
      _beneficiaries[index] = beneficiary;
    });
  }

  void _handleQueueNumberIssued(Queue queue, Beneficiary beneficiary, int queueNumber) {
    final index = _beneficiaries.indexWhere((b) => b.id == beneficiary.id);
    if (index != -1) {
      _updateBeneficiary(index, beneficiary);
    } else {
      _addBeneficiary(beneficiary);
    }
  }

  void _addEntity(String entity) {
    setState(() {
      if (!_entities.contains(entity)) {
        _entities.add(entity);
      }
    });
  }

  void _addDistributionArea(DistributionArea area) {
    setState(() {
      _distributionAreas.add(area);
    });
  }

  void _addAdminRequest(Admin admin) {
    AdminRequestStorage.addRequest(admin);
    setState(() {}); // Trigger rebuild to show updated list
  }

  int get _totalQueues => _queues.length;
  int get _activeQueues => _queues.where((q) => q.status == 'active' && !q.isCompleted).length;
  int get _totalBeneficiaries => _beneficiaries.length;

  Widget _buildSummaryCard(String title, int count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 24),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueRow(Queue queue, int index) {
    const tealGreen = Color(0xFF00BFA5);
    final beneficiariesForQueue = _beneficiaries.where((b) => b.initialAssignedQueuePoint == queue.name).toList();
    
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: index > 0 ? 24 : 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => QueueViewScreen(
                    queue: queue,
                    beneficiaries: _beneficiaries,
                    onQueueUpdated: (updatedQueue) => _updateQueue(index, updatedQueue),
                    onBeneficiaryUpdated: (beneficiary) {
                      final beneficiaryIndex = _beneficiaries.indexWhere((b) => b.id == beneficiary.id);
                      if (beneficiaryIndex != -1) {
                        _updateBeneficiary(beneficiaryIndex, beneficiary);
                      }
                    },
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        queue.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        queue.queuePoint,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: queue.status == 'active' 
                                  ? Colors.green.withOpacity(0.1)
                                  : queue.status == 'suspended'
                                      ? Colors.orange.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              queue.status.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: queue.status == 'active'
                                    ? Colors.green
                                    : queue.status == 'suspended'
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (queue.isCompleted)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'COMPLETED',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.visibility, color: tealGreen),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!queue.isCompleted) ...[
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _queues[index] = queue.copyWith(isStarted: true);
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QueueServingScreen(
                              queue: queue.copyWith(isStarted: true),
                              beneficiaries: beneficiariesForQueue,
                              onQueueUpdated: (updatedQueue) => _updateQueue(index, updatedQueue),
                              onBeneficiaryUpdated: (beneficiary) {
                                final beneficiaryIndex = _beneficiaries.indexWhere((b) => b.id == beneficiary.id);
                                if (beneficiaryIndex != -1) {
                                  _updateBeneficiary(beneficiaryIndex, beneficiary);
                                }
                              },
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.green),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.green.withOpacity(0.1),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Start',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _queues[index] = queue.copyWith(isSuspended: !queue.isSuspended, status: !queue.isSuspended ? 'suspended' : 'active');
                        });
                      },
                      icon: Icon(queue.isSuspended ? Icons.play_arrow : Icons.pause, color: Colors.orange),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange.withOpacity(0.1),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      queue.isSuspended ? 'Resume' : 'Suspend',
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _queues[index] = queue.copyWith(isCompleted: true);
                        });
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.blue),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.blue.withOpacity(0.1),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 4),
                  Text(
                    AppLanguage.translate('Complete'),
                    style: const TextStyle(fontSize: 10),
                  ),
                  ],
                ),
              ],
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QueueDetailsScreen(
                            queue: queue,
                            distributionAreas: _distributionAreas,
                            onQueueUpdated: (updatedQueue) => _updateQueue(index, updatedQueue),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit, color: tealGreen),
                    style: IconButton.styleFrom(
                      backgroundColor: tealGreen.withOpacity(0.1),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLanguage.translate('Edit'),
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(AppLanguage.translate('Delete Queue')),
                          content: Text(AppLanguage.translate('Are you sure you want to delete this queue?')),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(AppLanguage.translate('Cancel')),
                            ),
                            TextButton(
                              onPressed: () {
                                _deleteQueue(index);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppLanguage.translate('Queue deleted successfully'))),
                                );
                              },
                              child: Text(AppLanguage.translate('Delete'), style: const TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete, color: Colors.red),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLanguage.translate('Delete'),
                    style: const TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getScreen() {
    switch (_selectedIndex) {
      case 0: // Dashboard
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE8F5E9), Colors.white],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'App Statistics',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _buildSummaryCard('Total Queues', _totalQueues, Icons.queue, Colors.blue),
                      const SizedBox(width: 12),
                      _buildSummaryCard('Active Queues', _activeQueues, Icons.check_circle, Colors.green),
                      const SizedBox(width: 12),
                      _buildSummaryCard('Beneficiaries', _totalBeneficiaries, Icons.people, Colors.orange),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLanguage.translate('Our Queue List'),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: _queues.isEmpty
                              ? Center(
                                  child: Text(
                                    AppLanguage.translate('No queues yet. Add a new queue to get started.'),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: _queues.length,
                                  itemBuilder: (context, index) => _buildQueueRow(_queues[index], index),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case 1: // Add Queue
        return NewQueueScreen(
          onQueueCreated: (queue) {
            _addQueue(queue);
            setState(() {
              _selectedIndex = 0; // Switch back to dashboard
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Queue created successfully'))),
            );
          },
          distributionAreas: _distributionAreas,
        );
      case 2: // Add Beneficiary
        return BeneficiaryRegistrationScreen(
          queues: _queues,
          beneficiaries: _beneficiaries,
          distributionAreas: _distributionAreas,
          entities: _entities,
          onBeneficiaryCreated: (beneficiary) {
            _addBeneficiary(beneficiary);
            setState(() {
              _selectedIndex = 0; // Switch back to dashboard
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Beneficiary registered successfully'))),
            );
          },
          onEntityAdded: _addEntity,
        );
      case 3: // Beneficiaries List
        return BeneficiariesListScreen(
          beneficiaries: _beneficiaries,
          queues: _queues,
          distributionAreas: _distributionAreas,
          entities: _entities,
          onBeneficiaryUpdated: (beneficiary) {
            final index = _beneficiaries.indexWhere((b) => b.id == beneficiary.id);
            if (index != -1) {
              _updateBeneficiary(index, beneficiary);
            }
          },
          onEntityAdded: _addEntity,
        );
      case 4: // Add Distribution Area
        return AddDistributionAreaScreen(
          onAreaCreated: _addDistributionArea,
          onCancel: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        );
      default:
        return const Center(child: Text('Unknown screen'));
    }
  }

  Widget _buildDrawer(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF00BFA5), Color(0xFF26A69A)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF00BFA5), Color(0xFF26A69A)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Color(0xFF00BFA5)),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Admin User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'admin@eqms.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.white),
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white54, height: 1),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings, color: Colors.white),
              title: Text(
                AppLanguage.translate('Admin Management'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AdminManagementScreen(
                      admins: _admins,
                      adminRequests: _adminRequests,
                      distributionAreas: _distributionAreas,
                      onAdminCreated: (admin) {
                        setState(() {
                          _admins.add(admin);
                        });
                      },
                      onAdminRequestApproved: (admin) {
                        AdminRequestStorage.removeRequest(admin.id);
                        setState(() {
                          _admins.add(admin);
                        });
                      },
                      onAdminRequestRejected: (adminId) {
                        AdminRequestStorage.removeRequest(adminId);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.white),
              title: Text(
                AppLanguage.translate('Add Volunteer'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddVolunteerScreen(
                      distributionAreas: _distributionAreas,
                      onVolunteerAdded: (volunteer) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Volunteer added successfully')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assessment, color: Colors.white),
              title: Text(
                AppLanguage.translate('Reports'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReportsScreen(
                      queues: _queues,
                      beneficiaries: _beneficiaries,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: Text(
                AppLanguage.translate('Settings'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
            const Divider(color: Colors.white54, height: 1),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: Text(
                AppLanguage.translate('Logout'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(AppLanguage.translate('Logout')),
                    content: Text(AppLanguage.translate('Are you sure you want to logout?')),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLanguage.translate('Cancel')),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(AppLanguage.translate('Logout'), style: const TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EQMS Dashboard'),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Admin Management',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AdminManagementScreen(
                    admins: _admins,
                    adminRequests: _adminRequests,
                    distributionAreas: _distributionAreas,
                    onAdminCreated: (admin) {
                      setState(() {
                        _admins.add(admin);
                      });
                    },
                    onAdminRequestApproved: (admin) {
                      AdminRequestStorage.removeRequest(admin.id);
                      setState(() {
                        _admins.add(admin);
                      });
                    },
                    onAdminRequestRejected: (adminId) {
                      AdminRequestStorage.removeRequest(adminId);
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: _getScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF00BFA5),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add Queue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Add Beneficiary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Beneficiaries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Add Area',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => IssueQueueNumberScreen(
                queues: _queues,
                beneficiaries: _beneficiaries,
                onQueueNumberIssued: _handleQueueNumberIssued,
              ),
            ),
          );
        },
        backgroundColor: const Color(0xFF00BFA5),
        icon: const Icon(Icons.confirmation_number),
        label: const Text('Issue Queue Number'),
      ),
    );
  }
}

// New Queue Screen
class NewQueueScreen extends StatefulWidget {
  final Function(Queue) onQueueCreated;
  final List<DistributionArea> distributionAreas;

  const NewQueueScreen({
    super.key,
    required this.onQueueCreated,
    required this.distributionAreas,
  });

  @override
  State<NewQueueScreen> createState() => _NewQueueScreenState();
}

class _NewQueueScreenState extends State<NewQueueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _queueNameController = TextEditingController();
  final _unitNameController = TextEditingController();
  final _customUnitNameController = TextEditingController();
  
  String? _selectedDistributionArea;
  String? _selectedQueueType = 'Single Day';
  String? _selectedUnitName;
  DateTime? _fromDate;
  DateTime? _toDate;
  TimeOfDay? _fromTime;
  TimeOfDay? _toTime;
  int? _numberOfAvailableUnits;
  int? _estimatedQueueSize;
  bool _directServe = false;
  final List<String> _selectedPriority = [];
  String _status = 'active';

  @override
  void dispose() {
    _queueNameController.dispose();
    _unitNameController.dispose();
    _customUnitNameController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDistributionArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select a distribution area'))),
        );
        return;
      }
      if (_fromDate == null || _toDate == null || _fromTime == null || _toTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select date and time ranges')),
        );
        return;
      }
      if (_numberOfAvailableUnits == null || _estimatedQueueSize == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter number of units and estimated queue size')),
        );
        return;
      }

      // Get distribution area details
      DistributionArea? selectedArea;
      try {
        selectedArea = widget.distributionAreas.firstWhere(
          (area) => area.id == _selectedDistributionArea,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Distribution area not found. Please select a valid area.')),
        );
        return;
      }

      if (selectedArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select a distribution area'))),
        );
        return;
      }

      final queue = Queue(
        name: _queueNameController.text,
        queueManager: 'Admin User',
        country: selectedArea.country,
        governorate: selectedArea.governorate,
        city: selectedArea.city,
        queuePointName: selectedArea.areaName,
        distributionArea: _selectedDistributionArea!,
        queueType: _selectedQueueType!,
        fromDate: _fromDate!,
        toDate: _toDate!,
        fromTime: _fromTime!,
        toTime: _toTime!,
        unitName: _selectedUnitName == 'Others' ? _customUnitNameController.text : _selectedUnitName!,
        numberOfAvailableUnits: _numberOfAvailableUnits!,
        estimatedQueueSize: _estimatedQueueSize!,
        directServe: _directServe,
        priority: _selectedPriority,
        status: _status,
      );

      widget.onQueueCreated(queue);
    }
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    const darkBlue = Color(0xFF1A237E);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.translate('Add New Queue')),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                TextFormField(
                  controller: _queueNameController,
                  decoration: InputDecoration(
                    labelText: AppLanguage.translate('Queue Name *'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  validator: (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter queue name') : null,
                ),
                const SizedBox(height: 16),
                Text(AppLanguage.translate('Distribution Area *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedDistributionArea,
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: widget.distributionAreas.map((area) {
                    return DropdownMenuItem(
                      value: area.id,
                      child: Text(
                        area.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (context) {
                    return widget.distributionAreas.map((area) {
                      return Text(
                        area.fullName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    }).toList();
                  },
                  onChanged: (value) => setState(() => _selectedDistributionArea = value),
                ),
                const SizedBox(height: 16),
                Text(AppLanguage.translate('Queue Type *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedQueueType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: ['Single Day', 'Multi Day'].map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedQueueType = value),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLanguage.translate('From Date *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (date != null) setState(() => _fromDate = date);
                            },
                            child: Text(_fromDate == null ? AppLanguage.translate('Select Date') : '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLanguage.translate('To Date *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _fromDate ?? DateTime.now(),
                                firstDate: _fromDate ?? DateTime.now(),
                                lastDate: DateTime.now().add(const Duration(days: 365)),
                              );
                              if (date != null) setState(() => _toDate = date);
                            },
                            child: Text(_toDate == null ? AppLanguage.translate('Select Date') : '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLanguage.translate('From Time *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                              if (time != null) setState(() => _fromTime = time);
                            },
                            child: Text(_fromTime == null ? AppLanguage.translate('Select Time') : _fromTime!.format(context)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLanguage.translate('To Time *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                              if (time != null) setState(() => _toTime = time);
                            },
                            child: Text(_toTime == null ? AppLanguage.translate('Select Time') : _toTime!.format(context)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(AppLanguage.translate('Unit Name *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedUnitName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: ['Meals', 'Bags', 'Blankets', 'Others'].map((unit) {
                    return DropdownMenuItem(value: unit, child: Text(unit));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedUnitName = value),
                ),
                if (_selectedUnitName == 'Others') ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _customUnitNameController,
                    decoration: InputDecoration(
                      labelText: AppLanguage.translate('Custom Unit Name *'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: _selectedUnitName == 'Others' ? (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter unit name') : null : null,
                  ),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  controller: _unitNameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLanguage.translate('Number of Available Units *'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => _numberOfAvailableUnits = int.tryParse(value),
                  validator: (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter number of units') : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: AppLanguage.translate('Estimated Queue Size *'),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => _estimatedQueueSize = int.tryParse(value),
                  validator: (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter estimated queue size') : null,
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: Text(AppLanguage.translate('Direct Serve Option')),
                  value: _directServe,
                  onChanged: (value) => setState(() => _directServe = value ?? false),
                ),
                const SizedBox(height: 16),
                Text(AppLanguage.translate('Priority'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...['Female', 'Elderly', 'Disability'].map((priority) {
                  return CheckboxListTile(
                    title: Text(AppLanguage.translate(priority)),
                    value: _selectedPriority.contains(priority),
                    onChanged: (value) {
                      setState(() {
                        if (value ?? false) {
                          _selectedPriority.add(priority);
                        } else {
                          _selectedPriority.remove(priority);
                        }
                      });
                    },
                  );
                }),
                const SizedBox(height: 16),
                Text(AppLanguage.translate('Status *'), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: ['active', 'banned', 'suspended'].map((status) {
                    return DropdownMenuItem(value: status, child: Text(status.toUpperCase()));
                  }).toList(),
                  onChanged: (value) => setState(() => _status = value ?? 'active'),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleCreate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Create Queue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Queue Details Screen (for editing)
class QueueDetailsScreen extends StatefulWidget {
  final Queue queue;
  final List<DistributionArea> distributionAreas;
  final Function(Queue) onQueueUpdated;

  const QueueDetailsScreen({
    super.key,
    required this.queue,
    required this.distributionAreas,
    required this.onQueueUpdated,
  });

  @override
  State<QueueDetailsScreen> createState() => _QueueDetailsScreenState();
}

class _QueueDetailsScreenState extends State<QueueDetailsScreen> {
  late TextEditingController _queueNameController;
  late TextEditingController _queuePointNameController;
  late TextEditingController _unitNameController;
  late TextEditingController _customUnitNameController;
  
  late String? _selectedDistributionArea;
  late String? _selectedGovernorate;
  late String? _selectedCity;
  late String? _selectedQueueType;
  late String? _selectedUnitName;
  late DateTime _fromDate;
  late DateTime _toDate;
  late TimeOfDay _fromTime;
  late TimeOfDay _toTime;
  late int _numberOfAvailableUnits;
  late int _estimatedQueueSize;
  late bool _directServe;
  late List<String> _selectedPriority;
  late String _status;

  final Map<String, List<String>> _egyptGovernoratesCities = {
    'Cairo': ['Cairo', 'Nasr City', 'Heliopolis', 'Maadi', 'Zamalek', 'New Cairo', '6th of October City'],
    'Giza': ['Giza', 'Dokki', 'Mohandessin', 'Agouza', 'Faisal', 'Haram'],
    'Alexandria': ['Alexandria', 'Montaza', 'Sidi Bishr', 'Stanley', 'Smouha'],
    'Qalyubia': ['Banha', 'Qalyub', 'Shubra El Kheima', 'Tukh'],
    'Port Said': ['Port Said', 'Port Fouad'],
    'Suez': ['Suez', 'Arish'],
    'Dakahlia': ['Mansoura', 'Talkha', 'Mit Ghamr', 'Aga'],
    'Sharqia': ['Zagazig', '10th of Ramadan', 'Belbeis', 'Abu Hammad'],
    'Monufia': ['Shibin El Kom', 'Menouf', 'Tala', 'Ashmoun'],
    'Beheira': ['Damanhur', 'Kafr El Dawwar', 'Rashid', 'Edku'],
    'Gharbia': ['Tanta', 'Mahalla', 'Kafr El Zayat', 'Zefta'],
    'Kafr El Sheikh': ['Kafr El Sheikh', 'Desouk', 'Fuwa', 'Bilqas'],
    'Damietta': ['Damietta', 'New Damietta', 'Ras El Bar'],
    'Ismailia': ['Ismailia', 'Fayed', 'Abu Suwayr'],
    'North Sinai': ['Arish', 'Sheikh Zuweid', 'Rafah'],
    'South Sinai': ['Sharm El Sheikh', 'Dahab', 'Nuweiba', 'Taba'],
    'Red Sea': ['Hurghada', 'Marsa Alam', 'Safaga', 'El Gouna'],
    'New Valley': ['Kharga', 'Dakhla', 'Farafra'],
    'Matruh': ['Marsa Matruh', 'El Alamein', 'Sidi Barrani'],
    'Luxor': ['Luxor', 'Esna', 'Armant'],
    'Aswan': ['Aswan', 'Kom Ombo', 'Edfu'],
    'Qena': ['Qena', 'Luxor', 'Nag Hammadi'],
    'Sohag': ['Sohag', 'Akhmim', 'Girga'],
    'Assiut': ['Assiut', 'Abnoub', 'Manfalut'],
    'Minya': ['Minya', 'Malawi', 'Abu Qurqas'],
    'Beni Suef': ['Beni Suef', 'Biba', 'Al Fashn'],
    'Faiyum': ['Faiyum', 'Tamiya', 'Sinnuris'],
  };

  List<String> get _availableCities {
    if (_selectedGovernorate == null) return [];
    return _egyptGovernoratesCities[_selectedGovernorate] ?? [];
  }

  @override
  void initState() {
    super.initState();
    _queueNameController = TextEditingController(text: widget.queue.name);
    _queuePointNameController = TextEditingController(text: widget.queue.queuePointName);
    _unitNameController = TextEditingController();
    _customUnitNameController = TextEditingController();
    _selectedDistributionArea = widget.queue.distributionArea;
    _selectedGovernorate = widget.queue.governorate;
    _selectedCity = widget.queue.city;
    _selectedQueueType = widget.queue.queueType;
    _selectedUnitName = ['Meals', 'Bags', 'Blankets'].contains(widget.queue.unitName) ? widget.queue.unitName : 'Others';
    if (_selectedUnitName == 'Others') {
      _customUnitNameController.text = widget.queue.unitName;
    }
    _fromDate = widget.queue.fromDate;
    _toDate = widget.queue.toDate;
    _fromTime = widget.queue.fromTime;
    _toTime = widget.queue.toTime;
    _numberOfAvailableUnits = widget.queue.numberOfAvailableUnits;
    _estimatedQueueSize = widget.queue.estimatedQueueSize;
    _directServe = widget.queue.directServe;
    _selectedPriority = List.from(widget.queue.priority);
    _status = widget.queue.status;
  }

  @override
  void dispose() {
    _queueNameController.dispose();
    _queuePointNameController.dispose();
    _unitNameController.dispose();
    _customUnitNameController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    final updatedQueue = widget.queue.copyWith(
      name: _queueNameController.text,
      governorate: _selectedGovernorate,
      city: _selectedCity,
      queuePointName: _queuePointNameController.text,
      distributionArea: _selectedDistributionArea,
      queueType: _selectedQueueType,
      fromDate: _fromDate,
      toDate: _toDate,
      fromTime: _fromTime,
      toTime: _toTime,
      unitName: _selectedUnitName == 'Others' ? _customUnitNameController.text : _selectedUnitName,
      numberOfAvailableUnits: _numberOfAvailableUnits,
      estimatedQueueSize: _estimatedQueueSize,
      directServe: _directServe,
      priority: _selectedPriority,
      status: _status,
    );

    widget.onQueueUpdated(updatedQueue);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Queue updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Queue'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _queueNameController,
                decoration: InputDecoration(
                  labelText: 'Queue Name *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Distribution Area *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDistributionArea,
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: widget.distributionAreas.map((area) {
                  return DropdownMenuItem(
                    value: area.id,
                    child: Text(
                      area.fullName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return widget.distributionAreas.map((area) {
                    return Text(
                      area.fullName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    );
                  }).toList();
                },
                onChanged: (value) => setState(() => _selectedDistributionArea = value),
              ),
              const SizedBox(height: 16),
              const Text('Governorate *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedGovernorate,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _egyptGovernoratesCities.keys.map((gov) {
                  return DropdownMenuItem(value: gov, child: Text(gov));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGovernorate = value;
                    _selectedCity = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('City *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: _availableCities.map((city) {
                  return DropdownMenuItem(value: city, child: Text(city));
                }).toList(),
                onChanged: _selectedGovernorate == null ? null : (value) => setState(() => _selectedCity = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _queuePointNameController,
                decoration: InputDecoration(
                  labelText: 'Queue Point Name *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Queue Type *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedQueueType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Single Day', 'Multi Day'].map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => _selectedQueueType = value),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From Date *', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _fromDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) setState(() => _fromDate = date);
                          },
                          child: Text('${_fromDate.day}/${_fromDate.month}/${_fromDate.year}'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To Date *', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _toDate,
                              firstDate: _fromDate,
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) setState(() => _toDate = date);
                          },
                          child: Text('${_toDate.day}/${_toDate.month}/${_toDate.year}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From Time *', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: _fromTime);
                            if (time != null) setState(() => _fromTime = time);
                          },
                          child: Text(_fromTime.format(context)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To Time *', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () async {
                            final time = await showTimePicker(context: context, initialTime: _toTime);
                            if (time != null) setState(() => _toTime = time);
                          },
                          child: Text(_toTime.format(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Unit Name *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedUnitName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['Meals', 'Bags', 'Blankets', 'Others'].map((unit) {
                  return DropdownMenuItem(value: unit, child: Text(unit));
                }).toList(),
                onChanged: (value) => setState(() => _selectedUnitName = value),
              ),
              if (_selectedUnitName == 'Others') ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customUnitNameController,
                  decoration: InputDecoration(
                    labelText: 'Custom Unit Name *',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _unitNameController..text = _numberOfAvailableUnits.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number of Available Units *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => _numberOfAvailableUnits = int.tryParse(value) ?? _numberOfAvailableUnits,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _estimatedQueueSize.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Estimated Queue Size *',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => _estimatedQueueSize = int.tryParse(value) ?? _estimatedQueueSize,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Direct Serve Option'),
                value: _directServe,
                onChanged: (value) => setState(() => _directServe = value ?? false),
              ),
              const SizedBox(height: 16),
              const Text('Priority (optional)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...['Female', 'Elderly', 'Disability'].map((priority) {
                return CheckboxListTile(
                  title: Text(priority),
                  value: _selectedPriority.contains(priority),
                  onChanged: (value) {
                    setState(() {
                      if (value ?? false) {
                        _selectedPriority.add(priority);
                      } else {
                        _selectedPriority.remove(priority);
                      }
                    });
                  },
                );
              }),
              const SizedBox(height: 16),
              const Text('Status *', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: ['active', 'banned', 'suspended'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status.toUpperCase()));
                }).toList(),
                onChanged: (value) => setState(() => _status = value ?? 'active'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleUpdate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(AppLanguage.translate('Update Queue'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Admin Management Screen
class AdminManagementScreen extends StatefulWidget {
  final List<Admin> admins;
  final List<Admin> adminRequests;
  final List<DistributionArea> distributionAreas;
  final Function(Admin) onAdminCreated;
  final Function(Admin) onAdminRequestApproved;
  final Function(String) onAdminRequestRejected;

  const AdminManagementScreen({
    super.key,
    required this.admins,
    required this.adminRequests,
    required this.distributionAreas,
    required this.onAdminCreated,
    required this.onAdminRequestApproved,
    required this.onAdminRequestRejected,
  });

  @override
  State<AdminManagementScreen> createState() => _AdminManagementScreenState();
}

class _AdminManagementScreenState extends State<AdminManagementScreen> {
  int _selectedTab = 0; // 0: Create Admin, 1: Requests

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Management'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _selectedTab == 0 ? tealGreen : Colors.grey[200],
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedTab == 0 ? tealGreen : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      'Create Admin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _selectedTab == 0 ? Colors.white : Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _selectedTab == 1 ? tealGreen : Colors.grey[200],
                      border: Border(
                        bottom: BorderSide(
                          color: _selectedTab == 1 ? tealGreen : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Admin Requests',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: _selectedTab == 1 ? Colors.white : Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.adminRequests.isNotEmpty)
                          Positioned(
                            right: 8,
                            top: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${widget.adminRequests.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _selectedTab == 0
                ? CreateAdminScreen(
                    distributionAreas: widget.distributionAreas,
                    onAdminCreated: widget.onAdminCreated,
                  )
                : AdminRequestsScreen(
                    adminRequests: widget.adminRequests,
                    distributionAreas: widget.distributionAreas,
                    onRequestApproved: widget.onAdminRequestApproved,
                    onRequestRejected: widget.onAdminRequestRejected,
                  ),
          ),
        ],
      ),
    );
  }
}

// Create Admin Screen (Super Admin)
class CreateAdminScreen extends StatefulWidget {
  final List<DistributionArea> distributionAreas;
  final Function(Admin) onAdminCreated;

  const CreateAdminScreen({
    super.key,
    required this.distributionAreas,
    required this.onAdminCreated,
  });

  @override
  State<CreateAdminScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateAdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _notesController = TextEditingController();
  final _referenceController = TextEditingController();
  final _newDistributionPointController = TextEditingController();
  final _newDistributionPointDescController = TextEditingController();

  String? _selectedCountry = 'Egypt';
  String? _selectedGovernorate;
  String? _selectedCity;
  String? _selectedDistributionPoint;
  bool _useNewDistributionPoint = false;
  String _status = 'active';

  final Map<String, List<String>> _egyptGovernoratesCities = {
    'Cairo': ['Cairo', 'Nasr City', 'Heliopolis', 'Maadi', 'Zamalek'],
    'Giza': ['Giza', '6th of October', 'Sheikh Zayed', 'Dokki'],
    'Alexandria': ['Alexandria', 'Montaza', 'Sidi Bishr'],
    'Luxor': ['Luxor', 'Karnak'],
    'Aswan': ['Aswan', 'Elephantine'],
  };

  List<String> get _availableCities {
    if (_selectedGovernorate == null) return [];
    return _egyptGovernoratesCities[_selectedGovernorate] ?? [];
  }

  List<String> get _availableDistributionPoints {
    if (_selectedCity == null) return [];
    return widget.distributionAreas
        .where((area) => area.city == _selectedCity)
        .map((area) => area.areaName)
        .toList();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _notesController.dispose();
    _referenceController.dispose();
    _newDistributionPointController.dispose();
    _newDistributionPointDescController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      if (_selectedGovernorate == null || _selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select governorate and city')),
        );
        return;
      }
      if (_selectedDistributionPoint == null && !_useNewDistributionPoint) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select or create a distribution point')),
        );
        return;
      }
      if (_useNewDistributionPoint && _newDistributionPointController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter distribution point name')),
        );
        return;
      }

      final admin = Admin(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        country: _selectedCountry!,
        governorate: _selectedGovernorate!,
        city: _selectedCity!,
        distributionPoint: _useNewDistributionPoint
            ? _newDistributionPointController.text
            : _selectedDistributionPoint!,
        distributionPointDescription: _useNewDistributionPoint
            ? _newDistributionPointDescController.text
            : null,
        fullName: _fullNameController.text,
        mobile: _mobileController.text,
        notes: _notesController.text,
        reference: _referenceController.text.isNotEmpty ? _referenceController.text : null,
        status: _status,
        isRequestedByGuest: false,
        createdAt: DateTime.now(),
      );

      widget.onAdminCreated(admin);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin created successfully')),
      );
      
      // Reset form
      _formKey.currentState!.reset();
      setState(() {
        _selectedGovernorate = null;
        _selectedCity = null;
        _selectedDistributionPoint = null;
        _useNewDistributionPoint = false;
        _status = 'active';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    const darkBlue = Color(0xFF1A237E);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE8F5E9), Colors.white],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Admin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 32),
              _buildLabel('Country *'),
              const SizedBox(height: 8),
              _buildDropdown(
                _selectedCountry ?? '',
                ['Egypt'],
                (value) => setState(() => _selectedCountry = value),
              ),
              const SizedBox(height: 24),
              _buildLabel('Governorate *'),
              const SizedBox(height: 8),
              _buildDropdown(
                _selectedGovernorate ?? '',
                _egyptGovernoratesCities.keys.toList(),
                (value) => setState(() {
                  _selectedGovernorate = value;
                  _selectedCity = null;
                  _selectedDistributionPoint = null;
                }),
              ),
              const SizedBox(height: 24),
              _buildLabel('City *'),
              const SizedBox(height: 8),
              _buildDropdown(
                _selectedCity ?? '',
                _availableCities,
                (value) => setState(() {
                  _selectedCity = value;
                  _selectedDistributionPoint = null;
                }),
                enabled: _selectedGovernorate != null,
              ),
              const SizedBox(height: 24),
              _buildLabel('Distribution Point *'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      _selectedDistributionPoint ?? '',
                      [..._availableDistributionPoints, 'Other'],
                      (value) {
                        setState(() {
                          if (value == 'Other') {
                            _useNewDistributionPoint = true;
                            _selectedDistributionPoint = null;
                          } else {
                            _useNewDistributionPoint = false;
                            _selectedDistributionPoint = value;
                          }
                        });
                      },
                      enabled: _selectedCity != null,
                    ),
                  ),
                ],
              ),
              if (_useNewDistributionPoint) ...[
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newDistributionPointController,
                  decoration: _buildInputDecoration('Distribution Point Name *'),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newDistributionPointDescController,
                  maxLines: 3,
                  decoration: _buildInputDecoration('Distribution Point Description'),
                ),
              ],
              const SizedBox(height: 24),
              _buildLabel('Full Name *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fullNameController,
                decoration: _buildInputDecoration('Enter full name'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              _buildLabel('Mobile *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: _buildInputDecoration('Enter mobile number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                  if (!regex.hasMatch(value)) {
                    return 'Invalid Egyptian mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _buildLabel('Notes *'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: _buildInputDecoration('Enter notes'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 24),
              _buildLabel('Reference (Optional)'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _referenceController,
                decoration: _buildInputDecoration('Enter reference'),
              ),
              const SizedBox(height: 24),
              _buildLabel('Status *'),
              const SizedBox(height: 8),
              _buildDropdown(
                _status,
                ['pending', 'active', 'banned'],
                (value) => setState(() => _status = value ?? 'active'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: tealGreen,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      AppLanguage.translate(text),
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A237E)),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: AppLanguage.translate(hint),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged, {bool enabled = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.white : Colors.grey[200],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          isExpanded: true,
          hint: Text(enabled ? 'Select' : 'Select previous field first'),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}

// Admin Requests Screen
class AdminRequestsScreen extends StatelessWidget {
  final List<Admin> adminRequests;
  final List<DistributionArea> distributionAreas;
  final Function(Admin) onRequestApproved;
  final Function(String) onRequestRejected;

  const AdminRequestsScreen({
    super.key,
    required this.adminRequests,
    required this.distributionAreas,
    required this.onRequestApproved,
    required this.onRequestRejected,
  });

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE8F5E9), Colors.white],
        ),
      ),
      child: adminRequests.isEmpty
          ? const Center(
              child: Text(
                'No admin requests',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: adminRequests.length,
              itemBuilder: (context, index) {
                final request = adminRequests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    request.fullName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text('Mobile: ${request.mobile}'),
                                  Text('${request.country} > ${request.governorate} > ${request.city}'),
                                  Text('Distribution Point: ${request.distributionPoint}'),
                                  if (request.distributionPointDescription != null)
                                    Text('Description: ${request.distributionPointDescription}'),
                                  if (request.reference != null)
                                    Text('Reference: ${request.reference}'),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Notes: ${request.notes}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: request.status == 'pending'
                                    ? Colors.orange.withOpacity(0.1)
                                    : request.status == 'active'
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                request.status.toUpperCase(),
                                style: TextStyle(
                                  color: request.status == 'pending'
                                      ? Colors.orange
                                      : request.status == 'active'
                                          ? Colors.green
                                          : Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Reject Request'),
                                    content: const Text('Are you sure you want to reject this admin request?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          onRequestRejected(request.id);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Request rejected')),
                                          );
                                        },
                                        child: const Text('Reject', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Text('Reject'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {
                                final approvedAdmin = request.copyWith(status: 'active');
                                onRequestApproved(approvedAdmin);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Admin request approved')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: tealGreen,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Approve'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1A237E);
    const tealGreen = Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: tealGreen,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                'Admin User',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Super Admin',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildProfileItem(Icons.phone, 'Mobile', '+20 123 456 7890'),
              _buildProfileItem(Icons.email, 'Email', 'admin@eqmsapp.com'),
              _buildProfileItem(Icons.business, 'Company', 'App Statistics'),
              _buildProfileItem(Icons.location_on, 'Location', 'Cairo, Egypt'),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              _buildSettingItem(Icons.notifications, 'Notifications', () {}),
              _buildSettingItem(Icons.lock, 'Change Password', () {}),
              _buildSettingItem(Icons.language, 'Language', () {}),
              _buildSettingItem(Icons.help, 'Help & Support', () {}),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: const Text('Logout', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00BFA5)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A237E),
                  ),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF00BFA5), size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// Beneficiary Registration Screen
class BeneficiaryRegistrationScreen extends StatefulWidget {
  final List<Queue> queues;
  final List<Beneficiary> beneficiaries;
  final List<DistributionArea> distributionAreas;
  final List<String> entities;
  final Function(Beneficiary) onBeneficiaryCreated;
  final Function(String) onEntityAdded;

  const BeneficiaryRegistrationScreen({
    super.key,
    required this.queues,
    required this.beneficiaries,
    required this.distributionAreas,
    required this.entities,
    required this.onBeneficiaryCreated,
    required this.onEntityAdded,
  });

  @override
  State<BeneficiaryRegistrationScreen> createState() => _BeneficiaryRegistrationScreenState();
}

class _BeneficiaryRegistrationScreenState extends State<BeneficiaryRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _nfcCodeController = TextEditingController();
  final _customEntityController = TextEditingController();
  final _customUnitsController = TextEditingController();

  String? _selectedDistributionArea;
  String? _selectedQueuePoint;
  String _type = 'Normal';
  String _gender = 'Male';
  String _status = 'Active';
  String _numberOfUnits = '1';
  bool _isEntity = false;
  String? _selectedEntity;
  bool _useCustomUnits = false;
  bool _useCustomEntity = false;
  String? _idCopyPath;
  String? _photoPath;
  DateTime? _extractedBirthDate;
  String? _duplicateIDMessage;

  final List<String> _typeOptions = ['Normal', 'Child', 'Widowed', 'Divorced', 'Disability', 'Sick', 'Elderly'];
  final List<String> _genderOptions = ['Male', 'Female'];
  final List<String> _statusOptions = ['Active', 'Banned'];
  final List<String> _unitsOptions = ['1', '2'];

  List<Queue> get _filteredQueues {
    if (_selectedDistributionArea == null) return [];
    // Filter queues by distribution area ID
    return widget.queues.where((q) => q.distributionArea == _selectedDistributionArea).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _mobileNumberController.dispose();
    _nfcCodeController.dispose();
    _customEntityController.dispose();
    _customUnitsController.dispose();
    super.dispose();
  }

  Future<void> _scanID() async {
    // Simulate ID scanning - in real app, this would use camera/image picker
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Simulate extracting birth date from ID
    final simulatedBirthDate = DateTime(1965, 1, 1); // Example: before 1970
    
    setState(() {
      _idCopyPath = 'scanned_id_${DateTime.now().millisecondsSinceEpoch}.jpg';
      _extractedBirthDate = simulatedBirthDate;
      
      // Auto-detect Elderly if birth date is before 1970
      if (simulatedBirthDate.year < 1970 && _type == 'Normal') {
        _type = 'Elderly';
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLanguage.translate('ID scanned successfully'))),
    );
  }

  Future<void> _extractNameFromID() async {
    if (_idCopyPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLanguage.translate('Please scan ID first'))),
      );
      return;
    }
    
    // Simulate OCR extraction
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _nameController.text = 'Extracted Name from ID'; // In real app, this would be OCR result
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLanguage.translate('Name extracted from ID'))),
    );
  }

  Future<void> _takePhoto() async {
    // Show dialog to choose between camera and gallery
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Photo Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source == null) return;

    // Simulate taking/selecting photo
    // In real app, you would use image_picker package:
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: source);
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      _photoPath = 'beneficiary_photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Photo ${source == ImageSource.camera ? 'taken' : 'selected'} successfully')),
    );
  }

  void _checkDuplicateID(String idNumber) {
    // Check if ID already exists in beneficiaries list
    try {
      final existingBeneficiary = widget.beneficiaries.firstWhere(
        (b) => b.idNumber == idNumber,
      );
      
      setState(() {
        _duplicateIDMessage = 'This ID is already registered. Initial assigned queue: ${existingBeneficiary.initialAssignedQueuePoint}';
      });
    } catch (e) {
      // ID not found - no duplicate
      setState(() {
        _duplicateIDMessage = null;
      });
    }
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDistributionArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select a distribution area'))),
        );
        return;
      }
      if (_selectedQueuePoint == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select an initial assigned queue point'))),
        );
        return;
      }

      String entityName = '';
      if (_isEntity) {
        if (_useCustomEntity) {
          if (_customEntityController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Please enter entity name'))),
            );
            return;
          }
          entityName = _customEntityController.text;
          widget.onEntityAdded(entityName);
        } else {
          if (_selectedEntity == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLanguage.translate('Please select an entity'))),
            );
            return;
          }
          entityName = _selectedEntity!;
        }
      }

      String units = _numberOfUnits;
      if (_useCustomUnits) {
        if (_customUnitsController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLanguage.translate('Please enter number of units'))),
          );
          return;
        }
        units = _customUnitsController.text;
      }

      final beneficiary = Beneficiary(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        distributionArea: _selectedDistributionArea!,
        initialAssignedQueuePoint: _selectedQueuePoint!,
        type: _type,
        idCopyPath: _idCopyPath,
        gender: _gender,
        name: _nameController.text,
        idNumber: _idNumberController.text,
        mobileNumber: _mobileNumberController.text.isNotEmpty ? _mobileNumberController.text : null,
        isEntity: _isEntity,
        entityName: _isEntity ? entityName : null,
        numberOfUnits: units,
        nfcPreprintedCode: _nfcCodeController.text.isNotEmpty ? _nfcCodeController.text : null,
        photoPath: _photoPath,
        status: _status,
        birthDate: _extractedBirthDate,
      );

      widget.onBeneficiaryCreated(beneficiary);
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1A237E);
    const tealGreen = Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiary Registration'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Beneficiary Registration',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Distribution Area *'),
                const SizedBox(height: 8),
                _buildDistributionAreaDropdown(),
                const SizedBox(height: 24),
                _buildLabel('Initial Assigned Queue Point *'),
                const SizedBox(height: 8),
                _buildQueueDropdown(),
                const SizedBox(height: 24),
                _buildLabel('ID Copy *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _scanID,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(_idCopyPath != null ? AppLanguage.translate('ID Scanned') : AppLanguage.translate('Scan ID')),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _idCopyPath != null ? Colors.green : tealGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    if (_idCopyPath != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {},
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('Type *'),
                const SizedBox(height: 8),
                _buildDropdown(_type, _typeOptions, (value) => setState(() => _type = value ?? 'Normal')),
                const SizedBox(height: 24),
                _buildLabel('Gender *'),
                const SizedBox(height: 8),
                _buildDropdown(_gender, _genderOptions, (value) => setState(() => _gender = value ?? 'Male')),
                const SizedBox(height: 24),
                _buildLabel('Name *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration('Enter name or extract from ID'),
                        validator: (value) => value?.isEmpty ?? true ? AppLanguage.translate('Please enter name') : null,
                      ),
                    ),
                    if (_idCopyPath != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.auto_fix_high),
                        tooltip: 'Extract name from ID using OCR',
                        onPressed: _extractNameFromID,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('ID Number *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _idNumberController,
                  decoration: _buildInputDecoration('Enter ID number'),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter ID number' : null,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _checkDuplicateID(value);
                    }
                  },
                ),
                if (_duplicateIDMessage != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _duplicateIDMessage!,
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildLabel('Mobile Number'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration('Enter mobile number'),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid Egyptian mobile number';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildLabel('Number of Units *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        _numberOfUnits,
                        _unitsOptions,
                        (value) => setState(() {
                          _numberOfUnits = value ?? '1';
                          _useCustomUnits = false;
                        }),
                      ),
                    ),
                    Checkbox(
                      value: _useCustomUnits,
                      onChanged: (value) => setState(() => _useCustomUnits = value ?? false),
                    ),
                    const Text('Custom'),
                  ],
                ),
                if (_useCustomUnits) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _customUnitsController,
                    keyboardType: TextInputType.number,
                    decoration: _buildInputDecoration('Enter custom number of units'),
                  ),
                ],
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: const Text('Entity'),
                  value: _isEntity,
                  onChanged: (value) => setState(() => _isEntity = value ?? false),
                ),
                if (_isEntity) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedEntity,
                              isExpanded: true,
                              hint: const Text('Select entity'),
                              items: [...widget.entities, 'Other'].map((entity) {
                                return DropdownMenuItem(
                                  value: entity,
                                  child: Text(entity),
                                );
                              }).toList(),
                              onChanged: (value) => setState(() {
                                _selectedEntity = value;
                                _useCustomEntity = value == 'Other';
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_useCustomEntity) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _customEntityController,
                      decoration: _buildInputDecoration('Enter custom entity name'),
                    ),
                  ],
                ],
                const SizedBox(height: 24),
                _buildLabel('Photo (Optional)'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (_photoPath != null)
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          color: Colors.grey[200],
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 20, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    _photoPath = null;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: const Icon(Icons.person, size: 40, color: Colors.grey),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _takePhoto,
                        icon: const Icon(Icons.camera_alt),
                        label: Text(_photoPath != null ? 'Retake Photo' : 'Take Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildLabel('NFC Preprinted Code'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nfcCodeController,
                  decoration: _buildInputDecoration('Enter NFC code'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 0),
                  ),
                  child: const Text('Register Beneficiary'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      AppLanguage.translate(text),
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A237E)),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: AppLanguage.translate(hint),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDistributionAreaDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDistributionArea,
          isExpanded: true,
          hint: const Text('Select distribution area'),
          items: widget.distributionAreas.map((area) {
            return DropdownMenuItem(
              value: area.id,
              child: Text(
                area.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return widget.distributionAreas.map((area) {
              return Text(
                area.fullName,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              );
            }).toList();
          },
          onChanged: (value) {
            setState(() {
              _selectedDistributionArea = value;
              _selectedQueuePoint = null;
            });
          },
        ),
      ),
    );
  }

  Widget _buildQueueDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedQueuePoint,
          isExpanded: true,
          hint: Text(_selectedDistributionArea == null ? 'Select distribution area first' : 'Select queue point'),
          items: _filteredQueues.map((queue) {
            return DropdownMenuItem(value: queue.name, child: Text(queue.name));
          }).toList(),
          onChanged: _selectedDistributionArea == null ? null : (value) => setState(() => _selectedQueuePoint = value),
        ),
      ),
    );
  }
}

// Beneficiaries List Screen
class BeneficiariesListScreen extends StatelessWidget {
  final List<Beneficiary> beneficiaries;
  final List<Queue> queues;
  final List<DistributionArea> distributionAreas;
  final List<String> entities;
  final Function(Beneficiary) onBeneficiaryUpdated;
  final Function(String) onEntityAdded;

  const BeneficiariesListScreen({
    super.key,
    required this.beneficiaries,
    required this.queues,
    required this.distributionAreas,
    required this.entities,
    required this.onBeneficiaryUpdated,
    required this.onEntityAdded,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByQueue(beneficiaries);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiaries'),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
      ),
      body: grouped.isEmpty
          ? const Center(child: Text('No beneficiaries yet'))
          : ListView.builder(
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final entry = grouped.entries.elementAt(index);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${entry.key} (${entry.value.length})',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...entry.value.map((beneficiary) {
                      final idx = beneficiaries.indexOf(beneficiary);
                      return ListTile(
                        title: Text(beneficiary.name),
                        subtitle: Text('ID: ${beneficiary.idNumber}'),
                        trailing: Text(beneficiary.status),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BeneficiaryDetailsScreen(
                                beneficiary: beneficiary,
                                beneficiaryIndex: idx,
                                availableQueues: queues,
                                entities: entities,
                                onBeneficiaryUpdated: onBeneficiaryUpdated,
                                onBeneficiaryDeleted: () {},
                                onEntityAdded: onEntityAdded,
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                );
              },
            ),
    );
  }

  Map<String, List<Beneficiary>> _groupByQueue(List<Beneficiary> beneficiaries) {
    final map = <String, List<Beneficiary>>{};
    for (var beneficiary in beneficiaries) {
      final key = beneficiary.initialAssignedQueuePoint;
      map.putIfAbsent(key, () => []).add(beneficiary);
    }
    return map;
  }
}

// Beneficiary Details Screen
class BeneficiaryDetailsScreen extends StatefulWidget {
  final Beneficiary beneficiary;
  final int beneficiaryIndex;
  final List<Queue> availableQueues;
  final List<String> entities;
  final Function(Beneficiary) onBeneficiaryUpdated;
  final VoidCallback onBeneficiaryDeleted;
  final Function(String) onEntityAdded;

  const BeneficiaryDetailsScreen({
    super.key,
    required this.beneficiary,
    required this.beneficiaryIndex,
    required this.availableQueues,
    required this.entities,
    required this.onBeneficiaryUpdated,
    required this.onBeneficiaryDeleted,
    required this.onEntityAdded,
  });

  @override
  State<BeneficiaryDetailsScreen> createState() => _BeneficiaryDetailsScreenState();
}

class _BeneficiaryDetailsScreenState extends State<BeneficiaryDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  String? _selectedDistributionArea;
  String? _selectedQueuePoint;
  String _type = 'Normal';
  String _gender = 'Male';
  String _status = 'Active';
  String _numberOfUnits = '1';

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.beneficiary.name;
    _idNumberController.text = widget.beneficiary.idNumber;
    _mobileNumberController.text = widget.beneficiary.mobileNumber ?? '';
    _selectedDistributionArea = widget.beneficiary.distributionArea;
    _selectedQueuePoint = widget.beneficiary.initialAssignedQueuePoint;
    _type = widget.beneficiary.type;
    _gender = widget.beneficiary.gender;
    _status = widget.beneficiary.status;
    _numberOfUnits = widget.beneficiary.numberOfUnits;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idNumberController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  void _handleUpdate() {
    if (_formKey.currentState!.validate()) {
      final updated = widget.beneficiary.copyWith(
        distributionArea: _selectedDistributionArea!,
        initialAssignedQueuePoint: _selectedQueuePoint!,
        name: _nameController.text,
        idNumber: _idNumberController.text,
        mobileNumber: _mobileNumberController.text.isNotEmpty ? _mobileNumberController.text : null,
        type: _type,
        gender: _gender,
        status: _status,
        numberOfUnits: _numberOfUnits,
      );
      widget.onBeneficiaryUpdated(updated);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beneficiary Details'),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name *'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idNumberController,
                decoration: const InputDecoration(labelText: 'ID Number *'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid Egyptian mobile number';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleUpdate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BFA5),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Queue View Screen
class QueueViewScreen extends StatelessWidget {
  final Queue queue;
  final List<Beneficiary> beneficiaries;
  final Function(Queue) onQueueUpdated;
  final Function(Beneficiary) onBeneficiaryUpdated;

  const QueueViewScreen({
    super.key,
    required this.queue,
    required this.beneficiaries,
    required this.onQueueUpdated,
    required this.onBeneficiaryUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final beneficiariesForQueue = beneficiaries.where((b) => b.initialAssignedQueuePoint == queue.name).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(queue.name),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Queue Point: ${queue.queuePoint}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Type: ${queue.queueType}'),
                    Text('Date Range: ${queue.displayDateRange}'),
                    Text('Time Range: ${queue.displayTimeRange}'),
                    Text('Status: ${queue.status}'),
                    Text('Available Units: ${queue.numberOfAvailableUnits}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (!queue.isStarted && !queue.isCompleted)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onQueueUpdated(queue.copyWith(isStarted: true));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => QueueServingScreen(
                          queue: queue.copyWith(isStarted: true),
                          beneficiaries: beneficiariesForQueue,
                          onQueueUpdated: (updatedQueue) {
                            // Handle queue update
                          },
                          onBeneficiaryUpdated: (beneficiary) {
                            // Handle beneficiary update
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Start Queue'),
                ),
              ),
            const SizedBox(height: 24),
            const Text('Beneficiaries:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            beneficiariesForQueue.isEmpty
                ? const Text('No beneficiaries assigned to this queue')
                : Column(
                    children: beneficiariesForQueue.map((b) => Card(
                      child: ListTile(
                        title: Text(b.name),
                        subtitle: Text('ID: ${b.idNumber}${b.queueNumber != null ? '\nQueue #${b.queueNumber}' : ''}'),
                        trailing: Text(b.isServed ? 'Served' : 'Not Served', style: TextStyle(color: b.isServed ? Colors.green : Colors.grey)),
                      ),
                    )).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}

// Add Distribution Area Screen
class AddDistributionAreaScreen extends StatefulWidget {
  final Function(DistributionArea) onAreaCreated;
  final VoidCallback? onCancel;

  const AddDistributionAreaScreen({
    super.key,
    required this.onAreaCreated,
    this.onCancel,
  });

  @override
  State<AddDistributionAreaScreen> createState() => _AddDistributionAreaScreenState();
}

class _AddDistributionAreaScreenState extends State<AddDistributionAreaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _areaNameController = TextEditingController();
  String? _selectedGovernorate;
  String? _selectedCity;

  final Map<String, List<String>> _egyptGovernoratesCities = {
    'Cairo': ['Cairo', 'Nasr City', 'Heliopolis', 'Maadi', 'Zamalek'],
    'Giza': ['Giza', '6th of October', 'Sheikh Zayed', 'Dokki'],
    'Alexandria': ['Alexandria', 'Montaza', 'Sidi Bishr'],
    'Luxor': ['Luxor', 'Karnak'],
    'Aswan': ['Aswan', 'Elephantine'],
    'Sharm El Sheikh': ['Sharm El Sheikh', 'Naama Bay'],
  };

  @override
  void dispose() {
    _areaNameController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      if (_selectedGovernorate == null || _selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select governorate and city')),
        );
        return;
      }

      final area = DistributionArea(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        country: 'Egypt',
        governorate: _selectedGovernorate!,
        city: _selectedCity!,
        areaName: _areaNameController.text,
      );

      widget.onAreaCreated(area);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Distribution area created successfully')),
      );
      
      if (widget.onCancel != null) {
        widget.onCancel!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF1A237E);
    const tealGreen = Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Distribution Area'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Distribution Area',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Country'),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: 'Egypt',
                  enabled: false,
                  decoration: _buildInputDecoration('Egypt'),
                ),
                const SizedBox(height: 24),
                _buildLabel('Governorate *'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGovernorate,
                      isExpanded: true,
                      hint: const Text('Select governorate'),
                      items: _egyptGovernoratesCities.keys.map((gov) {
                        return DropdownMenuItem(value: gov, child: Text(gov));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGovernorate = value;
                          _selectedCity = null;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLabel('City *'),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCity,
                      isExpanded: true,
                      hint: Text(_selectedGovernorate == null ? 'Select governorate first' : 'Select city'),
                      items: _selectedGovernorate != null
                          ? _egyptGovernoratesCities[_selectedGovernorate]!.map((city) {
                              return DropdownMenuItem(value: city, child: Text(city));
                            }).toList()
                          : [],
                      onChanged: _selectedGovernorate == null ? null : (value) => setState(() => _selectedCity = value),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildLabel('Distribution Area Name *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _areaNameController,
                  decoration: _buildInputDecoration('Enter distribution area name'),
                  validator: (value) => value?.isEmpty ?? true ? 'Please enter distribution area name' : null,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleCreate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tealGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Create Area', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1A237E),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    const tealGreen = Color(0xFF00BFA5);
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      filled: true,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: tealGreen, width: 2),
      ),
    );
  }
}

// Queue Serving Screen
class QueueServingScreen extends StatefulWidget {
  final Queue queue;
  final List<Beneficiary> beneficiaries;
  final Function(Queue) onQueueUpdated;
  final Function(Beneficiary) onBeneficiaryUpdated;

  const QueueServingScreen({
    super.key,
    required this.queue,
    required this.beneficiaries,
    required this.onQueueUpdated,
    required this.onBeneficiaryUpdated,
  });

  @override
  State<QueueServingScreen> createState() => _QueueServingScreenState();
}

class _QueueServingScreenState extends State<QueueServingScreen> {
  late int _availableUnits;
  bool _isQueueDetailsExpanded = false;
  String? _servingOption;
  late List<Beneficiary> _localBeneficiaries;

  @override
  void initState() {
    super.initState();
    _availableUnits = widget.queue.numberOfAvailableUnits;
    _localBeneficiaries = List<Beneficiary>.from(widget.beneficiaries);
  }

  void _handleServingOption(String option) {
    setState(() {
      _servingOption = option;
    });
    Navigator.pop(context);
  }

  void _serveBeneficiary(int index, int units) {
    if (units <= 0 || _availableUnits < units) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough units available')),
      );
      return;
    }

    final beneficiary = _localBeneficiaries[index];
    final eligibleUnits = int.tryParse(beneficiary.numberOfUnits) ?? 1;
    final newUnitsTaken = beneficiary.unitsTaken + units;
    
    if (newUnitsTaken > eligibleUnits) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot exceed eligible units')),
      );
      return;
    }

    setState(() {
      _availableUnits -= units;
      _localBeneficiaries[index] = beneficiary.copyWith(
        unitsTaken: newUnitsTaken,
        isServed: newUnitsTaken >= eligibleUnits,
      );
    });

    widget.onBeneficiaryUpdated(_localBeneficiaries[index]);
    widget.onQueueUpdated(widget.queue.copyWith(numberOfAvailableUnits: _availableUnits));
  }

  @override
  Widget build(BuildContext context) {
    final sortedBeneficiaries = List<Beneficiary>.from(_localBeneficiaries);
    if (_servingOption == 'noOrder') {
      // No order - serve in any order
    } else {
      // Sort by queue number
      sortedBeneficiaries.sort((a, b) => (a.queueNumber ?? 0).compareTo(b.queueNumber ?? 0));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Serving: ${widget.queue.name}'),
        backgroundColor: const Color(0xFF00BFA5),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Serving Options'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('Grace 5 minutes'),
                        onTap: () => _handleServingOption('grace5'),
                      ),
                      ListTile(
                        title: const Text('Grace 10 minutes'),
                        onTap: () => _handleServingOption('grace10'),
                      ),
                      ListTile(
                        title: const Text('No Order Mode'),
                        onTap: () => _handleServingOption('noOrder'),
                      ),
                      ListTile(
                        title: const Text('Without Tickets'),
                        onTap: () => _handleServingOption('withoutTickets'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Available Units: $_availableUnits'),
                if (_servingOption != null) Text(_servingOption!),
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() => _isQueueDetailsExpanded = !_isQueueDetailsExpanded),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Queue Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(_isQueueDetailsExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: _isQueueDetailsExpanded
                ? Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.grey[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${widget.queue.name}'),
                        Text('Queue Point: ${widget.queue.queuePoint}'),
                        Text('Type: ${widget.queue.queueType}'),
                        Text('Date Range: ${widget.queue.displayDateRange}'),
                        Text('Time Range: ${widget.queue.displayTimeRange}'),
                        Text('Unit Name: ${widget.queue.unitName}'),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: sortedBeneficiaries.isEmpty
                ? const Center(child: Text('No beneficiaries assigned'))
                : ListView.builder(
                    itemCount: sortedBeneficiaries.length,
                    itemBuilder: (context, index) {
                      final beneficiary = sortedBeneficiaries[index];
                      final eligibleUnits = int.tryParse(beneficiary.numberOfUnits) ?? 1;
                      final remainingUnits = eligibleUnits - beneficiary.unitsTaken;
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: beneficiary.photoPath != null
                              ? CircleAvatar(backgroundImage: AssetImage(beneficiary.photoPath!))
                              : const CircleAvatar(child: Icon(Icons.person)),
                          title: Text(beneficiary.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Eligible for ${beneficiary.unitsTaken}/$eligibleUnits meals'),
                              if (beneficiary.entityName != null) Text('Entity: ${beneficiary.entityName}'),
                              if (beneficiary.queueNumber != null) Text('Queue #${beneficiary.queueNumber}'),
                            ],
                          ),
                          trailing: beneficiary.isServed
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : ElevatedButton(
                                  onPressed: remainingUnits > 0 && _availableUnits > 0
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              final unitsController = TextEditingController();
                                              return AlertDialog(
                                                title: const Text('Serve Units'),
                                                content: TextField(
                                                  controller: unitsController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Units to serve (max: $remainingUnits)',
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      final units = int.tryParse(unitsController.text) ?? 0;
                                                      if (units > 0 && units <= remainingUnits) {
                                                        _serveBeneficiary(
                                                          _localBeneficiaries.indexOf(beneficiary),
                                                          units,
                                                        );
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text('Serve'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      : null,
                                  child: const Text('Serve'),
                                ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Issue Queue Number Screen
class IssueQueueNumberScreen extends StatefulWidget {
  final List<Queue> queues;
  final List<Beneficiary> beneficiaries;
  final Function(Queue, Beneficiary, int) onQueueNumberIssued;

  const IssueQueueNumberScreen({
    super.key,
    required this.queues,
    required this.beneficiaries,
    required this.onQueueNumberIssued,
  });

  @override
  State<IssueQueueNumberScreen> createState() => _IssueQueueNumberScreenState();
}

class _IssueQueueNumberScreenState extends State<IssueQueueNumberScreen> {
  Queue? _selectedQueue;
  Beneficiary? _verifiedBeneficiary;
  String _searchInput = '';
  String _searchType = 'ID'; // ID, Mobile, or NFC
  int? _issuedQueueNumber;
  bool _isNFCScanning = false;

  int get _currentQueueNumber {
    if (_selectedQueue == null) return 0;
    final beneficiariesInQueue = widget.beneficiaries
        .where((b) => b.initialAssignedQueuePoint == _selectedQueue!.name && b.queueNumber != null)
        .length;
    return beneficiariesInQueue + 1;
  }

  int get _totalAttendees {
    if (_selectedQueue == null) return 0;
    return widget.beneficiaries
        .where((b) => b.initialAssignedQueuePoint == _selectedQueue!.name && b.queueNumber != null)
        .length;
  }

  void _verifyBeneficiary() {
    if (_searchInput.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter ID number, mobile number, or scan NFC card')),
      );
      return;
    }

    Beneficiary? foundBeneficiary;

    if (_searchType == 'ID') {
      try {
        foundBeneficiary = widget.beneficiaries.firstWhere(
          (b) => b.idNumber == _searchInput,
        );
      } catch (e) {
        foundBeneficiary = null;
      }
    } else if (_searchType == 'Mobile') {
      try {
        foundBeneficiary = widget.beneficiaries.firstWhere(
          (b) => b.mobileNumber == _searchInput,
        );
      } catch (e) {
        foundBeneficiary = null;
      }
    } else if (_searchType == 'NFC') {
      try {
        foundBeneficiary = widget.beneficiaries.firstWhere(
          (b) => b.nfcPreprintedCode == _searchInput,
        );
      } catch (e) {
        foundBeneficiary = null;
      }
    }

    if (foundBeneficiary == null || foundBeneficiary.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beneficiary not found')),
      );
      return;
    }

    // Check eligibility - beneficiary must be assigned to this queue's distribution area
    if (_selectedQueue != null && foundBeneficiary.distributionArea != _selectedQueue!.distributionArea) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Beneficiary is not eligible for this queue')),
      );
      return;
    }

    // Check if already has a queue number for this queue
    if (foundBeneficiary.initialAssignedQueuePoint == _selectedQueue?.name && foundBeneficiary.queueNumber != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Beneficiary already has queue number: ${foundBeneficiary.queueNumber}')),
      );
      final existingQueueNumber = foundBeneficiary.queueNumber;
      setState(() {
        _verifiedBeneficiary = foundBeneficiary;
        _issuedQueueNumber = existingQueueNumber;
      });
      return;
    }

    setState(() {
      _verifiedBeneficiary = foundBeneficiary;
      _issuedQueueNumber = null;
    });
  }

  void _issueQueueNumber() {
    if (_selectedQueue == null || _verifiedBeneficiary == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select queue and verify beneficiary')),
      );
      return;
    }

    final queueNumber = _currentQueueNumber;
    
    // Update beneficiary with queue number
    final updatedBeneficiary = _verifiedBeneficiary!.copyWith(
      initialAssignedQueuePoint: _selectedQueue!.name,
      queueNumber: queueNumber,
    );

    widget.onQueueNumberIssued(_selectedQueue!, updatedBeneficiary, queueNumber);

    setState(() {
      _issuedQueueNumber = queueNumber;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Queue number $queueNumber issued successfully')),
    );
  }

  Future<void> _scanNFC() async {
    setState(() {
      _isNFCScanning = true;
    });

    // Simulate NFC scanning
    await Future.delayed(const Duration(milliseconds: 1000));

    // In real app, this would use NFC plugin to read the card
    // For demo, we'll use the first beneficiary with NFC code
    try {
      final nfcBeneficiary = widget.beneficiaries.firstWhere(
        (b) => b.nfcPreprintedCode != null && b.nfcPreprintedCode!.isNotEmpty,
      );

      if (nfcBeneficiary.id.isNotEmpty) {
        setState(() {
          _searchInput = nfcBeneficiary.nfcPreprintedCode!;
          _searchType = 'NFC';
          _isNFCScanning = false;
        });
        _verifyBeneficiary();
      }
    } catch (e) {
      setState(() {
        _isNFCScanning = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No NFC card detected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    const darkBlue = Color(0xFF1A237E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Queue Number'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Issue Queue Number',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text('Select Queue *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Queue>(
                          value: _selectedQueue,
                          isExpanded: true,
                          hint: const Text('Select queue'),
                          items: widget.queues.map((queue) {
                            return DropdownMenuItem(
                              value: queue,
                              child: Text(
                                queue.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedQueue = value;
                              _verifiedBeneficiary = null;
                              _issuedQueueNumber = null;
                              _searchInput = '';
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Verify Beneficiary *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _searchType,
                                isExpanded: true,
                                items: ['ID', 'Mobile', 'NFC'].map((type) {
                                  return DropdownMenuItem(
                                    value: type,
                                    child: Text(
                                      type,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  );
                                }).toList(),
                                selectedItemBuilder: (context) {
                                  return ['ID', 'Mobile', 'NFC'].map((type) {
                                    return Text(
                                      type,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    );
                                  }).toList();
                                },
                                onChanged: (value) => setState(() => _searchType = value ?? 'ID'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: _searchType == 'ID' 
                                  ? 'Enter ID number'
                                  : _searchType == 'Mobile'
                                      ? 'Enter mobile number'
                                      : 'Scan NFC or enter code',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onChanged: (value) => setState(() => _searchInput = value),
                            onSubmitted: (_) => _verifyBeneficiary(),
                          ),
                        ),
                        if (_searchType == 'NFC') ...[
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _isNFCScanning ? null : _scanNFC,
                            icon: _isNFCScanning
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : const Icon(Icons.nfc),
                            label: const Text('Scan'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tealGreen,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _verifyBeneficiary,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Verify Beneficiary'),
                    ),
                    if (_verifiedBeneficiary != null) ...[
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                    color: Colors.grey[200],
                                  ),
                                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _verifiedBeneficiary!.name,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text('ID: ${_verifiedBeneficiary!.idNumber}'),
                                      Text('Type: ${_verifiedBeneficiary!.type}'),
                                      Text('Gender: ${_verifiedBeneficiary!.gender}'),
                                      if (_verifiedBeneficiary!.mobileNumber != null)
                                        Text('Mobile: ${_verifiedBeneficiary!.mobileNumber}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (_issuedQueueNumber != null) ...[
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: tealGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: tealGreen, width: 2),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Queue Number Issued',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: tealGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '$_issuedQueueNumber',
                                      style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: tealGreen,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Current Queue Number: $_currentQueueNumber',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              if (_selectedQueue != null) ...[
                                Text(
                                  'Available Units: ${_selectedQueue!.numberOfAvailableUnits}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Eligible Units: ${_verifiedBeneficiary!.numberOfUnits}',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: _issueQueueNumber,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tealGreen,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 0),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  child: const Text('Issue Queue Number'),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (_selectedQueue != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Total Attendees', '$_totalAttendees', Icons.people),
                    _buildStatItem('Available Units', '${_selectedQueue!.numberOfAvailableUnits}', Icons.inventory),
                    _buildStatItem('Estimated Size', '${_selectedQueue!.estimatedQueueSize}', Icons.assessment),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF00BFA5), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A237E),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Request Admin Account Screen (Guest)
class RequestAdminAccountScreen extends StatefulWidget {
  final List<DistributionArea> distributionAreas;
  final Function(Admin) onRequestSubmitted;

  const RequestAdminAccountScreen({
    super.key,
    required this.distributionAreas,
    required this.onRequestSubmitted,
  });

  @override
  State<RequestAdminAccountScreen> createState() => _RequestAdminAccountScreenState();
}

class _RequestAdminAccountScreenState extends State<RequestAdminAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _otpController = TextEditingController();
  final _notesController = TextEditingController();
  final _referenceController = TextEditingController();
  final _newQueuePointController = TextEditingController();
  final _newQueuePointDescController = TextEditingController();

  String? _selectedCountry = 'Egypt';
  String? _selectedGovernorate;
  String? _selectedCity;
  String? _selectedQueuePoint;
  bool _useNewQueuePoint = false;
  bool _isOTPVerified = false;
  String? _otpCode;
  bool _isOTPSent = false;

  final Map<String, List<String>> _egyptGovernoratesCities = {
    'Cairo': ['Cairo', 'Nasr City', 'Heliopolis', 'Maadi', 'Zamalek'],
    'Giza': ['Giza', '6th of October', 'Sheikh Zayed', 'Dokki'],
    'Alexandria': ['Alexandria', 'Montaza', 'Sidi Bishr'],
    'Luxor': ['Luxor', 'Karnak'],
    'Aswan': ['Aswan', 'Elephantine'],
  };

  List<String> get _availableCities {
    if (_selectedGovernorate == null) return [];
    return _egyptGovernoratesCities[_selectedGovernorate] ?? [];
  }

  List<String> get _availableQueuePoints {
    if (_selectedCity == null) return [];
    return widget.distributionAreas
        .where((area) => area.city == _selectedCity)
        .map((area) => area.areaName)
        .toList();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _otpController.dispose();
    _notesController.dispose();
    _referenceController.dispose();
    _newQueuePointController.dispose();
    _newQueuePointDescController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (_mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter mobile number first')),
      );
      return;
    }

    final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
    if (!regex.hasMatch(_mobileController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid Egyptian mobile number')),
      );
      return;
    }

    // Simulate OTP sending
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Generate random 6-digit OTP
    _otpCode = (100000 + (DateTime.now().millisecondsSinceEpoch % 900000)).toString();
    
    setState(() {
      _isOTPSent = true;
      _isOTPVerified = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to ${_mobileController.text}. OTP: $_otpCode (for demo)')),
    );
  }

  void _verifyOTP() {
    if (_otpController.text == _otpCode) {
      setState(() {
        _isOTPVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP verified successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again')),
      );
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (!_isOTPVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please verify mobile number with OTP first')),
        );
        return;
      }
      if (_selectedGovernorate == null || _selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select governorate and city')),
        );
        return;
      }
      if (_selectedQueuePoint == null && !_useNewQueuePoint) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select or create a queue point')),
        );
        return;
      }
      if (_useNewQueuePoint && _newQueuePointController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter queue point name')),
        );
        return;
      }

      final adminRequest = Admin(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        country: _selectedCountry!,
        governorate: _selectedGovernorate!,
        city: _selectedCity!,
        distributionPoint: _useNewQueuePoint
            ? _newQueuePointController.text
            : _selectedQueuePoint!,
        distributionPointDescription: _useNewQueuePoint
            ? _newQueuePointDescController.text
            : null,
        fullName: _fullNameController.text,
        mobile: _mobileController.text,
        notes: _notesController.text,
        reference: _referenceController.text.isNotEmpty ? _referenceController.text : null,
        status: 'pending',
        isRequestedByGuest: true,
        createdAt: DateTime.now(),
      );

      widget.onRequestSubmitted(adminRequest);
      
      if (!mounted) return;
      
      Navigator.of(context).pop();
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin request submitted successfully. Waiting for approval.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    const darkBlue = Color(0xFF1A237E);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Admin Account'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Request Admin Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fill in your information to request admin access',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                _buildLabel('Country *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedCountry ?? '',
                  ['Egypt'],
                  (value) => setState(() => _selectedCountry = value),
                ),
                const SizedBox(height: 24),
                _buildLabel('Governorate *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedGovernorate ?? '',
                  _egyptGovernoratesCities.keys.toList(),
                  (value) => setState(() {
                    _selectedGovernorate = value;
                    _selectedCity = null;
                    _selectedQueuePoint = null;
                  }),
                ),
                const SizedBox(height: 24),
                _buildLabel('City *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedCity ?? '',
                  _availableCities,
                  (value) => setState(() {
                    _selectedCity = value;
                    _selectedQueuePoint = null;
                  }),
                  enabled: _selectedGovernorate != null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Q Point (Distribution Point) *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildDropdown(
                        _selectedQueuePoint ?? '',
                        [..._availableQueuePoints, 'Other'],
                        (value) {
                          setState(() {
                            if (value == 'Other') {
                              _useNewQueuePoint = true;
                              _selectedQueuePoint = null;
                            } else {
                              _useNewQueuePoint = false;
                              _selectedQueuePoint = value;
                            }
                          });
                        },
                        enabled: _selectedCity != null,
                      ),
                    ),
                  ],
                ),
                if (_useNewQueuePoint) ...[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newQueuePointController,
                    decoration: _buildInputDecoration('Queue Point Name *'),
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _newQueuePointDescController,
                    maxLines: 3,
                    decoration: _buildInputDecoration('Queue Point Description'),
                  ),
                ],
                const SizedBox(height: 24),
                _buildLabel('Full Name *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  decoration: _buildInputDecoration('Enter full name'),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Mobile *'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        decoration: _buildInputDecoration('Enter mobile number'),
                        enabled: !_isOTPVerified,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                          if (!regex.hasMatch(value)) {
                            return 'Invalid Egyptian mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _isOTPVerified ? null : _sendOTP,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(_isOTPVerified ? 'Verified' : 'Send OTP'),
                    ),
                  ],
                ),
                if (_isOTPSent && !_isOTPVerified) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _otpController,
                          keyboardType: TextInputType.number,
                          decoration: _buildInputDecoration('Enter OTP'),
                          maxLength: 6,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _verifyOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealGreen,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Verify'),
                      ),
                    ],
                  ),
                ],
                if (_isOTPVerified) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          'Mobile number verified',
                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                _buildLabel('Notes *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: _buildInputDecoration('Enter notes'),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Reference (Optional)'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _referenceController,
                  decoration: _buildInputDecoration('Enter reference'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      AppLanguage.translate(text),
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A237E)),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: AppLanguage.translate(hint),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged, {bool enabled = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.white : Colors.grey[200],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          isExpanded: true,
          hint: Text(enabled ? 'Select' : 'Select previous field first'),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}

// Reports Screen
class ReportsScreen extends StatelessWidget {
  final List<Queue> queues;
  final List<Beneficiary> beneficiaries;

  const ReportsScreen({
    super.key,
    required this.queues,
    required this.beneficiaries,
  });

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    final activeQueues = queues.where((q) => q.status == 'active' && !q.isCompleted).length;
    final totalBeneficiaries = beneficiaries.length;
    final servedBeneficiaries = beneficiaries.where((b) => b.isServed == true).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.translate('Reports')),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLanguage.translate('Statistics Overview'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 24),
              _buildStatCard(
                AppLanguage.translate('Total Queues'),
                queues.length.toString(),
                Icons.queue,
                Colors.blue,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                AppLanguage.translate('Active Queues'),
                activeQueues.toString(),
                Icons.check_circle,
                Colors.green,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                AppLanguage.translate('Total Beneficiaries'),
                totalBeneficiaries.toString(),
                Icons.people,
                Colors.orange,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                AppLanguage.translate('Served Beneficiaries'),
                servedBeneficiaries.toString(),
                Icons.done_all,
                Colors.teal,
              ),
              const SizedBox(height: 32),
              Text(
                AppLanguage.translate('Queue Details'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              const SizedBox(height: 16),
              ...queues.map((queue) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: queue.status == 'active' ? Colors.green : Colors.grey,
                    child: const Icon(Icons.queue, color: Colors.white),
                  ),
                  title: Text(queue.name),
                  subtitle: Text('${AppLanguage.translate('Status')}: ${queue.status}'),
                  trailing: Text('${queue.numberOfAvailableUnits} ${AppLanguage.translate('units')}'),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              AppLanguage.translate('Preferences'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: SwitchListTile(
                title: Text(AppLanguage.translate('Enable Notifications')),
                subtitle: Text(AppLanguage.translate('Receive push notifications')),
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: tealGreen,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: SwitchListTile(
                title: Text(AppLanguage.translate('Dark Mode')),
                subtitle: Text(AppLanguage.translate('Switch to dark theme')),
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
                activeColor: tealGreen,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLanguage.translate('Language'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text(AppLanguage.translate('Language')),
                subtitle: Text(_selectedLanguage == 'English' ? AppLanguage.translate('English') : AppLanguage.translate('Arabic')),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLanguage.translate('Select Language')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(AppLanguage.translate('English')),
                            onTap: () {
                              AppLanguage.setLanguage('English');
                              setState(() {
                                _selectedLanguage = 'English';
                              });
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text(AppLanguage.translate('Arabic')),
                            onTap: () {
                              AppLanguage.setLanguage('Arabic');
                              setState(() {
                                _selectedLanguage = 'Arabic';
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLanguage.translate('About'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                title: Text(AppLanguage.translate('App Version')),
                subtitle: const Text('1.0.0'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: Text(AppLanguage.translate('Terms & Conditions')),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: Text(AppLanguage.translate('Privacy Policy')),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Volunteer Screen
class AddVolunteerScreen extends StatefulWidget {
  final List<DistributionArea> distributionAreas;
  final Function(Map<String, dynamic>) onVolunteerAdded;

  const AddVolunteerScreen({
    super.key,
    required this.distributionAreas,
    required this.onVolunteerAdded,
  });

  @override
  State<AddVolunteerScreen> createState() => _AddVolunteerScreenState();
}

class _AddVolunteerScreenState extends State<AddVolunteerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedDistributionArea;
  String? _selectedCountry = 'Egypt';
  String? _selectedGovernorate;
  String? _selectedCity;

  final Map<String, List<String>> _egyptGovernoratesCities = {
    'Cairo': ['Cairo', 'Nasr City', 'Heliopolis', 'Maadi', 'Zamalek'],
    'Giza': ['Giza', '6th of October', 'Sheikh Zayed', 'Dokki'],
    'Alexandria': ['Alexandria', 'Montaza', 'Sidi Bishr'],
    'Luxor': ['Luxor', 'Karnak'],
    'Aswan': ['Aswan', 'Elephantine'],
  };

  List<String> get _availableCities {
    if (_selectedGovernorate == null) return [];
    return _egyptGovernoratesCities[_selectedGovernorate] ?? [];
  }

  List<String> get _availableDistributionAreas {
    if (_selectedCity == null) return [];
    return widget.distributionAreas
        .where((area) => area.city == _selectedCity)
        .map((area) => area.areaName)
        .toList();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDistributionArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLanguage.translate('Please select a distribution area'))),
        );
        return;
      }

      final volunteer = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'fullName': _fullNameController.text,
        'mobile': _mobileController.text,
        'email': _emailController.text,
        'distributionArea': _selectedDistributionArea,
        'country': _selectedCountry,
        'governorate': _selectedGovernorate,
        'city': _selectedCity,
        'notes': _notesController.text,
        'createdAt': DateTime.now(),
      };

      widget.onVolunteerAdded(volunteer);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    const tealGreen = Color(0xFF00BFA5);
    const darkText = Color(0xFF2D3748);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.translate('Add Volunteer')),
        backgroundColor: tealGreen,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Volunteer',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 32),
                _buildLabel('Full Name *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _fullNameController,
                  decoration: _buildInputDecoration('Enter full name'),
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Mobile *'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: _buildInputDecoration('Enter mobile number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    final regex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
                    if (!regex.hasMatch(value)) {
                      return 'Invalid Egyptian mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildLabel('Email'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration('Enter email (optional)'),
                ),
                const SizedBox(height: 24),
                _buildLabel('Country *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedCountry ?? '',
                  ['Egypt'],
                  (value) => setState(() => _selectedCountry = value),
                ),
                const SizedBox(height: 24),
                _buildLabel('Governorate *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedGovernorate ?? '',
                  _egyptGovernoratesCities.keys.toList(),
                  (value) => setState(() {
                    _selectedGovernorate = value;
                    _selectedCity = null;
                    _selectedDistributionArea = null;
                  }),
                ),
                const SizedBox(height: 24),
                _buildLabel('City *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedCity ?? '',
                  _availableCities,
                  (value) => setState(() {
                    _selectedCity = value;
                    _selectedDistributionArea = null;
                  }),
                  enabled: _selectedGovernorate != null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Distribution Area *'),
                const SizedBox(height: 8),
                _buildDropdown(
                  _selectedDistributionArea ?? '',
                  _availableDistributionAreas,
                  (value) => setState(() => _selectedDistributionArea = value),
                  enabled: _selectedCity != null,
                ),
                const SizedBox(height: 24),
                _buildLabel('Notes'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  decoration: _buildInputDecoration('Enter notes (optional)'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _handleAdd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tealGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Add Volunteer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF2D3748)),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _buildDropdown(String value, List<String> items, Function(String?) onChanged, {bool enabled = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.white : Colors.grey[200],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value.isEmpty ? null : value,
          isExpanded: true,
          hint: Text(enabled ? 'Select' : 'Select previous field first'),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ),
    );
  }
}

