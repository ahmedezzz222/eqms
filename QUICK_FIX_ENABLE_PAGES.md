# 🚨 URGENT: Enable GitHub Pages - Step by Step

## The Problem
The workflow cannot run because GitHub Pages is **NOT enabled** in your repository settings.

## Solution (Takes 30 seconds):

### Method 1: Direct Link (Easiest)
1. **Click this link**: https://github.com/ahmedezzz222/eqms/settings/pages
2. You should see a page with "GitHub Pages" settings
3. Under **"Source"** section, you'll see a dropdown
4. **Select "GitHub Actions"** from the dropdown
5. Click **"Save"** button
6. Wait 10-20 seconds for GitHub to process

### Method 2: Manual Navigation
1. Go to: https://github.com/ahmedezzz222/eqms
2. Click **"Settings"** tab (top menu, next to "Insights")
3. Scroll down in the left sidebar, click **"Pages"**
4. Under **"Source"**, select **"GitHub Actions"**
5. Click **"Save"**

## After Enabling Pages:

1. **Wait 1-2 minutes** for GitHub to set up Pages
2. Go to: https://github.com/ahmedezzz222/eqms/actions
3. Click **"Deploy Flutter Web to GitHub Pages"** workflow
4. Click **"Run workflow"** button (top right)
5. Select **"main"** branch
6. Click green **"Run workflow"** button

## Verify Pages is Enabled:

After enabling, you should see:
- ✅ A message saying "Your site is live at https://ahmedezzz222.github.io/eqms/"
- ✅ The "Source" dropdown shows "GitHub Actions"

## If You Don't See the Pages Option:

**Possible reasons:**
1. **Repository is private** - GitHub Pages only works for:
   - Public repositories (free)
   - Private repositories with GitHub Pro/Team/Enterprise (paid)

2. **Solution for private repos:**
   - Make repository public: Settings → Danger Zone → Change visibility → Make public
   - OR upgrade to GitHub Pro

## Still Not Working?

If you've enabled Pages but still get errors:
1. Make sure you selected **"GitHub Actions"** (NOT "Deploy from a branch")
2. Wait 2-3 minutes after enabling
3. Check repository is public (if using free account)
4. Verify in Settings → Actions → Workflow permissions is set to "Read and write"

