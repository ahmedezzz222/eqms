# Building an IPA for iPhone

An **IPA** (iOS App Store Package) can only be built on **macOS** with **Xcode** installed. It cannot be built on Windows.

## Option 1: Build on a Mac (recommended)

1. **Clone or copy the project to a Mac** (e.g. from GitHub):
   ```bash
   git clone https://github.com/ahmedezzz222/eqms.git
   cd eqms
   ```

2. **Install Flutter on the Mac** (if not already):
   - https://docs.flutter.dev/get-started/install/macos

3. **Open the iOS project in Xcode once** to set up signing:
   ```bash
   open ios/Runner.xcworkspace
   ```
   - Select the **Runner** project in the left sidebar.
   - Select the **Runner** target → **Signing & Capabilities**.
   - Check **Automatically manage signing** and choose your **Team** (Apple Developer account).
   - Ensure a valid **Bundle Identifier** is set (e.g. `com.et3amapp.eqmsapp`).

4. **Build the IPA** from the project root:
   ```bash
   flutter pub get
   flutter build ipa
   ```

5. **Find the IPA**:
   - Path: `build/ios/ipa/eqmsapp.ipa`
   - You can upload this to **App Store Connect** (for TestFlight/App Store) or use **ad-hoc** distribution to install on your iPhone (with UDID registered).

## Option 2: Install on your iPhone without IPA (development)

If you have a Mac and just want to run the app on your iPhone:

1. Connect your iPhone via USB.
2. Run:
   ```bash
   flutter run
   ```
   Flutter will build and install the app on the device (development signing).

## Option 3: Build with GitHub Actions (in this repo)

This repo includes a **Build iOS IPA** workflow that runs on macOS.

1. **Without secrets**: Push to `main` or run the workflow manually from the **Actions** tab. The workflow will run `flutter build ios --release --no-codesign` to verify the project compiles (no IPA is produced).
2. **With secrets**: Add the required Apple code signing secrets to the repository (see [.github/IOS_IPA_SECRETS.md](.github/IOS_IPA_SECRETS.md)). Then run the workflow; it will build the IPA and upload it as an **artifact**. Download from **Actions** → run → **Artifacts** → **ios-ipa**.

See **[.github/IOS_IPA_SECRETS.md](.github/IOS_IPA_SECRETS.md)** for the list of secrets and how to get them (certificate, provisioning profile, Team ID, etc.).

## Option 4: Other CI/CD (Codemagic, Bitrise, etc.)

- **Codemagic** (https://codemagic.io) – Flutter-focused, free tier available.
- **Bitrise**, **App Center**, etc.

You push your code; the service builds the IPA and can publish to TestFlight.

## Requirements summary

| Requirement        | Details |
|--------------------|--------|
| macOS              | Required for IPA build |
| Xcode              | From Mac App Store |
| Apple Developer    | Free account for device run; paid ($99/year) for TestFlight/App Store |
| Signing            | Configured in Xcode (Signing & Capabilities) |

## Quick reference (on a Mac)

```bash
cd /path/to/eqms
flutter pub get
flutter build ipa
# IPA output: build/ios/ipa/eqmsapp.ipa
```
