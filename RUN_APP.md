# 🚀 How to Run the App

## Quick Command

From the project root directory (`D:\XYZ\Docs\DevArea\eqmsapp`):

```powershell
C:\flutter\bin\flutter.bat run
```

## Or Add Flutter to PATH

To use `flutter` command directly, add Flutter to your PATH:

1. Open System Properties → Environment Variables
2. Edit "Path" in User variables
3. Add: `C:\flutter\bin`
4. Restart PowerShell

Then you can use:
```powershell
flutter run
```

## Current Directory Issue

If you're in `build\web` directory, navigate to project root first:

```powershell
cd D:\XYZ\Docs\DevArea\eqmsapp
C:\flutter\bin\flutter.bat run
```

---

**The app is now running! Check the console for Firestore setup messages.**

