# Setup GitHub Pages for Automatic Deployment

## Step-by-Step Instructions

### 1. Enable GitHub Pages in Repository Settings

1. Go to your repository: https://github.com/ahmedezzz222/eqms
2. Click on **Settings** (top menu bar)
3. Scroll down to **Pages** in the left sidebar
4. Under **Source**, select **"GitHub Actions"** (NOT "Deploy from a branch")
5. Click **Save**

### 2. Verify Workflow Permissions

1. Still in **Settings**
2. Go to **Actions** → **General**
3. Under **Workflow permissions**, make sure:
   - ✅ **Read and write permissions** is selected
   - ✅ **Allow GitHub Actions to create and approve pull requests** is checked (optional)
4. Click **Save**

### 3. Trigger the Workflow

After enabling GitHub Pages, you can:

**Option A: Wait for automatic trigger**
- The workflow will run automatically on the next push to `main` branch

**Option B: Manual trigger**
- Go to **Actions** tab
- Select **"Deploy Flutter Web to GitHub Pages"** workflow
- Click **"Run workflow"** button
- Select `main` branch
- Click **"Run workflow"**

### 4. Check Deployment Status

1. Go to **Actions** tab
2. You should see the workflow running
3. Wait for it to complete (green checkmark = success)
4. Once successful, your app will be available at:
   - **https://ahmedezzz222.github.io/eqms/**

### 5. Troubleshooting

If you still get errors:

1. **Check Actions logs**: Click on the failed workflow run to see detailed error messages
2. **Verify Pages is enabled**: Go to Settings → Pages and confirm "GitHub Actions" is selected
3. **Check repository permissions**: Make sure the repository is public or you have GitHub Pro/Team/Enterprise
4. **Wait a few minutes**: Sometimes it takes a moment for GitHub to enable Pages after configuration

### Important Notes

- GitHub Pages is **free for public repositories**
- For private repositories, you need **GitHub Pro, Team, or Enterprise**
- The first deployment may take 5-10 minutes
- Subsequent deployments are usually faster (2-3 minutes)

