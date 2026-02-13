# iOS IPA build – GitHub Actions secrets

The workflow **Build iOS IPA** (`.github/workflows/build-ios-ipa.yml`) runs on macOS and can produce an IPA when **code signing secrets** are set in the repository.

## When no secrets are set

- The workflow still runs and executes **Build iOS only (no signing)**.
- It runs `flutter build ios --release --no-codesign` to check that the project compiles.
- **No IPA is produced** (expected). You’ll see a notice in the job summary.

## When secrets are set

- The workflow imports your certificate and provisioning profile, configures signing, and runs **Build IPA (with signing)**.
- It runs `flutter build ipa` and uploads the **ipa** as a job artifact.
- Download it from: **Actions** → select the run → **Artifacts** → **ios-ipa**.

---

## Required repository secrets

Add these under **Settings** → **Secrets and variables** → **Actions** → **New repository secret**.

| Secret name | Description |
|-------------|--------------|
| `APPLE_CERTIFICATE_BASE64` | Your **Apple Distribution** (or **Apple Development** for ad-hoc) certificate exported as `.p12`, then **Base64-encoded** (see below). |
| `APPLE_CERTIFICATE_PASSWORD` | Password you set when exporting the `.p12`. |
| `APPLE_PROVISIONING_PROFILE_BASE64` | Your **App Store** or **Ad Hoc** provisioning profile (`.mobileprovision`) file, **Base64-encoded** (see below). |
| `KEYCHAIN_PASSWORD` | Any strong random string; used only to create a temporary keychain in CI. |
| `DEVELOPMENT_TEAM_ID` | Your Apple **Team ID** (10 characters, e.g. `ABCD123456`). Find it in [Apple Developer](https://developer.apple.com/account) → Membership. |
| `PROVISIONING_PROFILE_NAME` | **Exact name** of the provisioning profile as shown in Apple Developer (e.g. `eqmsapp AppStore` or `eqmsapp AdHoc`). |

---

## How to get the values

### 1. Certificate (`.p12`)

1. On a **Mac**, open **Keychain Access**.
2. Find your **Apple Distribution** (or **Apple Development**) certificate.
3. Right‑click → **Export** → save as `.p12` and set a password.
4. Base64-encode the file (in Terminal):
   ```bash
   base64 -i YourCertificate.p12 -o certificate_base64.txt
   ```
5. Put the **contents** of `certificate_base64.txt` into the secret `APPLE_CERTIFICATE_BASE64`.
6. Put the export password into `APPLE_CERTIFICATE_PASSWORD`.

### 2. Provisioning profile (`.mobileprovision`)

1. In [Apple Developer](https://developer.apple.com/account) → **Certificates, Identifiers & Profiles** → **Profiles**, download the **App Store** or **Ad Hoc** profile for this app.
2. Base64-encode it:
   ```bash
   base64 -i YourProfile.mobileprovision -o profile_base64.txt
   ```
3. Put the **contents** of `profile_base64.txt` into the secret `APPLE_PROVISIONING_PROFILE_BASE64`.
4. Copy the **exact profile name** (as shown in the portal) into `PROVISIONING_PROFILE_NAME`.

### 3. Team ID and keychain password

- **DEVELOPMENT_TEAM_ID**: From [developer.apple.com/account](https://developer.apple.com/account) → Membership details.
- **KEYCHAIN_PASSWORD**: Generate any random string (e.g. `openssl rand -base64 32`).

---

## Bundle ID

The app uses **Bundle ID** `com.et3amappios.eqmsapp`. Your provisioning profile and App ID in Apple Developer must match this.

---

## Running the workflow

- **Manual**: **Actions** → **Build iOS IPA** → **Run workflow**.
- **Automatic**: Pushes to `main` that touch `lib/`, `ios/`, `pubspec.yaml`, or this workflow file will trigger the job.

After a successful run with secrets set, download the IPA from **Artifacts** and install via TestFlight, Ad Hoc, or your preferred method.
