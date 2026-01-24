# Testing Guide: Egyptian National ID OCR

This guide explains how to test the OCR functionality for extracting data from Egyptian National ID cards.

## 📱 Where to Test

The OCR scanning feature is available in **3 screens**:

1. **Guest Beneficiary Registration Screen** (Guest Dashboard → Register Beneficiary)
2. **Beneficiary Registration Screen** (Admin Dashboard → Beneficiaries → Add Beneficiary)
3. **Beneficiary Details/Edit Screen** (Admin Dashboard → Beneficiaries → Edit Beneficiary)

## 🧪 Testing Steps

### Step 1: Navigate to Registration Screen

**Option A - Guest Registration:**
1. Launch the app
2. If you see a login screen, look for "Guest" or "Skip" option
3. Navigate to "Register Beneficiary" or "Add Beneficiary"

**Option B - Admin Registration:**
1. Login as Admin
2. Go to Dashboard
3. Navigate to "Beneficiaries" → "Add Beneficiary"

### Step 2: Find the Scan ID Button

Look for one of these buttons:
- **"Scan ID"** button (camera icon)
- **"Live Text Detection"** button (Google Lens icon) - if available
- **"Auto Scan (Google Lens-like)"** option in a dialog

### Step 3: Test OCR Scanning

#### Method 1: Camera (Recommended)
1. Tap **"Scan ID"** button
2. Select **"Camera"** option
3. Grant camera permission if prompted
4. Take a photo of an Egyptian National ID card
5. The app will:
   - Show a cropping screen (adjust if needed)
   - Process the image with OCR
   - Extract and fill form fields automatically

#### Method 2: Gallery
1. Tap **"Scan ID"** button
2. Select **"Gallery"** option
3. Grant storage permission if prompted
4. Select a photo of an Egyptian National ID card from your gallery
5. The app will process and extract data

#### Method 3: Google Lens (If Available)
1. Tap **"Live Text Detection"** button
2. Google Lens will open
3. Point camera at the ID card
4. Copy the detected text
5. Return to the app - data will be automatically filled

### Step 4: Verify Extracted Data

After scanning, check that these fields are automatically filled:

✅ **ID Number** (14 digits) - Should be extracted from bottom-right of card
✅ **Name** (Arabic) - Should be extracted from top section
✅ **Birth Date** - Extracted from ID number or text
✅ **Gender** - Extracted from ID number (Male/Female)
✅ **Address** (if visible) - Extracted from middle section
✅ **Birth Location** (if visible) - Extracted from card text

### Step 5: Review Console Logs

Open your IDE's console/debug output to see detailed logs:

```
✅ ID Number found in bottom section: 12345678901234
✅ Using custom extraction for ID: 12345678901234
   Birth Date: 1990-05-15
   Gender: Male
✅ Data extracted and filled automatically
```

## 📋 What to Test

### Test Case 1: Valid ID Card
- **Input**: Clear photo of Egyptian National ID card
- **Expected**: All fields filled correctly
- **Verify**: 
  - ID number is 14 digits
  - Name is in Arabic
  - Birth date matches ID number
  - Gender is correct

### Test Case 2: Blurry Image
- **Input**: Blurry or low-quality photo
- **Expected**: 
  - Warning message about image quality
  - Partial data extraction
  - Option to retry

### Test Case 3: Cropped Image
- **Input**: Photo that needs cropping
- **Expected**: 
  - Cropping screen appears
  - User can adjust crop area
  - OCR processes cropped image

### Test Case 4: Different ID Card Formats
- **Input**: Various ID card layouts
- **Expected**: 
  - Adapts to different card formats
  - Extracts available data
  - Handles missing fields gracefully

### Test Case 5: Manual Correction
- **Input**: Any scanned ID
- **Expected**: 
  - User can manually edit extracted data
  - Form validation works
  - Can save with corrected data

## 🔍 What to Look For

### ✅ Success Indicators:
- Green checkmark appears after successful scan
- Form fields are automatically filled
- No error messages
- Console shows "✅ Data extracted"

### ⚠️ Warning Signs:
- "Image appears blurry" message
- Missing or incorrect data
- Fields not filled
- Error messages in console

### 🐛 Debugging Tips:

1. **Check Console Logs:**
   - Look for "✅" success messages
   - Check for "⚠️" warnings
   - Review "❌" error messages

2. **Image Quality:**
   - Ensure good lighting
   - Hold camera steady
   - Focus on the ID card
   - Avoid glare/reflections

3. **Permissions:**
   - Camera permission granted
   - Storage permission granted (for gallery)

4. **ID Card Requirements:**
   - Card should be clearly visible
   - Text should be readable
   - Card should fill most of the frame

## 📊 Expected Results

### From ID Number (14 digits):
- **Birth Date**: Extracted from digits 2-7 (YYMMDD format)
- **Gender**: Determined from check digit (even = Female, odd = Male)
- **Century**: From first digit (2 = 1900-1999, 3 = 2000-2099)

### From OCR Text:
- **Name**: Arabic text from top section
- **Address**: Arabic text from middle section
- **Birth Location**: Location text from card
- **Religion**: If visible (مسلم/مسيحى/يهودى)
- **Marital Status**: If visible (أعزب/متجوز/مطلّق/أرمل)

## 🎯 Test Scenarios

### Scenario 1: Complete Success
1. Take clear photo of ID card
2. All fields auto-filled correctly
3. User reviews and saves
4. ✅ Beneficiary registered successfully

### Scenario 2: Partial Success
1. Take photo with some blur
2. Some fields filled, some missing
3. User manually fills missing fields
4. ✅ Beneficiary registered with corrections

### Scenario 3: Retry Needed
1. Take blurry photo
2. App shows quality warning
3. User taps "Retry" or "Take Another Photo"
4. Takes better photo
5. ✅ Data extracted successfully

## 📝 Notes

- The OCR uses **Google ML Kit Text Recognition**
- Supports **Arabic and English** text
- Handles **Arabic-Indic digits** (۰۱۲۳۴۵۶۷۸۹)
- Includes **image preprocessing** for better accuracy
- Has **confidence scoring** for extracted fields
- Falls back to **custom extraction** if package unavailable

## 🚀 Quick Test Checklist

- [ ] Navigate to beneficiary registration screen
- [ ] Tap "Scan ID" button
- [ ] Grant camera permission
- [ ] Take photo of ID card
- [ ] Verify cropping screen appears
- [ ] Confirm image is processed
- [ ] Check that fields are auto-filled
- [ ] Verify ID number is correct (14 digits)
- [ ] Verify name is extracted
- [ ] Verify birth date is correct
- [ ] Verify gender is correct
- [ ] Test with different image qualities
- [ ] Test manual editing of extracted data
- [ ] Test saving beneficiary with scanned data

## 💡 Tips for Best Results

1. **Lighting**: Use good, even lighting (avoid shadows)
2. **Distance**: Hold phone 20-30cm from card
3. **Angle**: Keep camera parallel to card (avoid tilt)
4. **Focus**: Tap to focus before taking photo
5. **Stability**: Hold phone steady or use a stand
6. **Clean Card**: Ensure card is clean and not damaged
7. **Full Card**: Include entire card in frame

---

**Happy Testing! 🎉**

If you encounter issues, check the console logs for detailed error messages.

