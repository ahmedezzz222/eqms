# Build Flutter web and deploy to Firebase Hosting
# Run from project root. Requires: Flutter in PATH, Firebase CLI (firebase login first).

Set-Location $PSScriptRoot

Write-Host "Building Flutter web..." -ForegroundColor Cyan
flutter build web
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Deploying to Firebase Hosting..." -ForegroundColor Cyan
firebase deploy --only hosting
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host ""
Write-Host "Web app live at:" -ForegroundColor Green
Write-Host "  https://et3am-ca94c.web.app" -ForegroundColor Yellow
Write-Host "  https://et3am-ca94c.firebaseapp.com" -ForegroundColor Yellow
