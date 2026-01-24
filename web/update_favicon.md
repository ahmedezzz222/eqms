# Update Web Favicon and Icons

To replace the Flutter logo with your app logo in the web browser tab:

## Option 1: Manual Method (Recommended)

1. **Convert your logo to PNG format:**
   - Open `assets/images/et3am_app_logo.jpeg` in an image editor
   - Export/save as PNG format

2. **Create the required sizes:**
   - `favicon.png` - 32x32 or 48x48 pixels (for browser tab)
   - `icons/Icon-192.png` - 192x192 pixels
   - `icons/Icon-512.png` - 512x512 pixels
   - `icons/Icon-maskable-192.png` - 192x192 pixels (same as Icon-192.png)
   - `icons/Icon-maskable-512.png` - 512x512 pixels (same as Icon-512.png)

3. **Replace the files:**
   - Copy `favicon.png` to `web/favicon.png`
   - Copy the icon files to `web/icons/` directory

## Option 2: Using Online Tools

1. Visit https://realfavicongenerator.net/
2. Upload your `et3am_app_logo.jpeg`
3. Generate all favicon sizes
4. Download and replace the files in `web/` directory

## Option 3: Using ImageMagick (if installed)

Run these commands in PowerShell:
```powershell
# Install ImageMagick first if not installed
# Then convert the logo to required sizes
magick assets\images\et3am_app_logo.jpeg -resize 32x32 web\favicon.png
magick assets\images\et3am_app_logo.jpeg -resize 192x192 web\icons\Icon-192.png
magick assets\images\et3am_app_logo.jpeg -resize 512x512 web\icons\Icon-512.png
copy web\icons\Icon-192.png web\icons\Icon-maskable-192.png
copy web\icons\Icon-512.png web\icons\Icon-maskable-512.png
```

After replacing the files, rebuild the web app:
```bash
flutter build web --release
```

