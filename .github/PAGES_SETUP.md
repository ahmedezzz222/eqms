# Fix: "Get Pages site failed" when deploying to GitHub Pages

That error means **GitHub Pages is not enabled** for this repo, or it is not set to use **GitHub Actions** as the source.

## Fix (one-time)

1. Open your repo on GitHub: **https://github.com/ahmedezzz222/eqms**
2. Go to **Settings** → **Pages** (left sidebar).
3. Under **Build and deployment**:
   - **Source**: choose **GitHub Actions** (not "Deploy from a branch").
4. Save. You don’t need to create a branch or select a branch.
5. Re-run the workflow: **Actions** → **Deploy Flutter Web to GitHub Pages** → **Run workflow**.

After that, the deploy workflow should run without the "Get Pages site failed" error.

## Optional: Let the action try to enable Pages

If you add a **Personal Access Token (PAT)** with `repo` or **Pages** scope as a repository secret named `PAGES_DEPLOY_TOKEN`, the workflow can try to enable Pages for you (see `enablement` in the workflow). Enabling Pages in **Settings → Pages** as above is usually enough.
