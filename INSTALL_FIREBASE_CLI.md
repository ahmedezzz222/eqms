# Install Firebase CLI - Step by Step

## Step 1: Install Node.js (if not installed)

1. **Download Node.js**: https://nodejs.org/
   - Download the LTS version (recommended)
   - Run the installer
   - Make sure "Add to PATH" is checked during installation

2. **Verify Installation**:
   ```powershell
   node --version
   npm --version
   ```

   You should see version numbers. If not, restart your terminal/PowerShell.

---

## Step 2: Install Firebase CLI

Open PowerShell (as Administrator if possible) and run:

```powershell
npm install -g firebase-tools
```

**Note**: The `-g` flag installs it globally so you can use `firebase` command anywhere.

---

## Step 3: Verify Installation

```powershell
firebase --version
```

You should see the Firebase CLI version number.

---

## Step 4: Login to Firebase

```powershell
firebase login
```

This will:
1. Open your browser
2. Ask you to login with your Google account
3. Authorize Firebase CLI
4. Return to PowerShell showing "Success! Logged in as..."

---

## Step 5: Install FlutterFire CLI

```powershell
dart pub global activate flutterfire_cli
```

---

## Step 6: Configure Your App

Navigate to your project root:
```powershell
cd D:\XYZ\Docs\DevArea\eqmsapp
```

Then run:
```powershell
flutterfire configure
```

Or if the command is not found:
```powershell
flutter pub global run flutterfire_cli:configure
```

---

## Troubleshooting

### "npm: command not found"
- Node.js is not installed or not in PATH
- Reinstall Node.js and make sure "Add to PATH" is checked
- Restart PowerShell after installation

### "firebase: command not found" after installation
- Try restarting PowerShell
- Check if npm global bin is in PATH:
  ```powershell
  npm config get prefix
  ```
- Add that path to your system PATH environment variable

### "dart: command not found"
- Flutter is not in PATH
- Add Flutter bin to PATH, or use full path:
  ```powershell
  C:\path\to\flutter\bin\dart pub global activate flutterfire_cli
  ```

---

## Alternative: Use FlutterFire CLI Directly

If Firebase CLI gives you trouble, you can use FlutterFire CLI directly:

```powershell
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure (this will handle Firebase login internally)
flutter pub global run flutterfire_cli:configure
```

---

## Quick Command Summary

```powershell
# 1. Install Node.js from nodejs.org

# 2. Install Firebase CLI
npm install -g firebase-tools

# 3. Login
firebase login

# 4. Install FlutterFire CLI
dart pub global activate flutterfire_cli

# 5. Navigate to project
cd D:\XYZ\Docs\DevArea\eqmsapp

# 6. Configure
flutterfire configure
# OR
flutter pub global run flutterfire_cli:configure
```

---

**After installation, you'll be able to use `firebase` and `flutterfire` commands!**

