# Deploying Flutter Web App to GitHub Pages

## Option 1: Using GitHub Actions (Recommended)

1. **Enable GitHub Pages in your repository:**
   - Go to your repository on GitHub
   - Click on **Settings** → **Pages**
   - Under "Source", select **GitHub Actions**

2. **Push the workflow file:**
   - The `.github/workflows/deploy.yml` file is already created
   - Commit and push it to your repository
   - GitHub Actions will automatically build and deploy your app

3. **Access your app:**
   - After deployment, your app will be available at:
   - `https://[your-username].github.io/[repository-name]/`

## Option 2: Manual Deployment

1. **Build the web app locally:**
   ```bash
   flutter build web --release
   ```

2. **Initialize git in build/web (if not already):**
   ```bash
   cd build/web
   git init
   git add .
   git commit -m "Deploy Flutter web app"
   ```

3. **Create a gh-pages branch:**
   ```bash
   git checkout -b gh-pages
   git remote add origin https://github.com/[your-username]/[repository-name].git
   git push -u origin gh-pages --force
   ```

4. **Enable GitHub Pages:**
   - Go to repository **Settings** → **Pages**
   - Select **gh-pages** branch as source
   - Save

## Option 3: Using gh-pages package (Alternative)

1. **Install gh-pages:**
   ```bash
   npm install -g gh-pages
   ```

2. **Deploy:**
   ```bash
   flutter build web --release
   gh-pages -d build/web
   ```

## Important Notes:

- The web build is located in `build/web` directory
- Make sure your `index.html` has the correct base href if deploying to a subdirectory
- For GitHub Pages subdirectory deployment, you may need to update the base href in `index.html`:
  ```html
  <base href="/[repository-name]/">
  ```

## Troubleshooting:

- If the app doesn't load, check the browser console for errors
- Ensure all assets are properly referenced
- Check that the base href matches your repository name
- Verify that GitHub Pages is enabled and pointing to the correct branch

