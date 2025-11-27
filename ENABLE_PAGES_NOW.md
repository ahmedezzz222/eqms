# ⚠️ CRITICAL: Enable GitHub Pages First!

## The Error You're Seeing

The workflow cannot automatically enable GitHub Pages. You **MUST** enable it manually in your repository settings first.

## Quick Fix (Do This Now):

### Step 1: Enable GitHub Pages
1. Go to: **https://github.com/ahmedezzz222/eqms/settings/pages**
2. Under **"Source"**, select **"GitHub Actions"** 
3. Click **"Save"**

### Step 2: Check Repository Visibility
- **Public repositories**: GitHub Pages works automatically
- **Private repositories**: You need GitHub Pro/Team/Enterprise plan

If your repo is private and you don't have a paid plan, you have two options:
- Make the repository public (Settings → Danger Zone → Change visibility)
- Or upgrade to GitHub Pro

### Step 3: Verify Workflow Permissions
1. Go to: **https://github.com/ahmedezzz222/eqms/settings/actions**
2. Scroll to **"Workflow permissions"**
3. Select: **"Read and write permissions"**
4. Check: **"Allow GitHub Actions to create and approve pull requests"** (optional)
5. Click **"Save"**

### Step 4: Run the Workflow Again
1. Go to: **https://github.com/ahmedezzz222/eqms/actions**
2. Click on the failed workflow run
3. Click **"Re-run jobs"** → **"Re-run all jobs"**

OR manually trigger:
1. Go to **Actions** tab
2. Select **"Deploy Flutter Web to GitHub Pages"**
3. Click **"Run workflow"**
4. Select `main` branch
5. Click **"Run workflow"**

## After Enabling Pages

Once Pages is enabled and the workflow succeeds, your app will be live at:
**https://ahmedezzz222.github.io/eqms/**

## Still Having Issues?

If you still get errors after enabling Pages:
1. Wait 2-3 minutes after enabling Pages (GitHub needs time to set it up)
2. Check if your repository is public (required for free GitHub Pages)
3. Verify the workflow has "Read and write permissions" in Settings → Actions
4. Check the Actions logs for specific error messages

