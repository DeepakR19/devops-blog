#!/usr/bin/env bash
set -e

echo "======================================"
echo " Hugo Full Auto Setup Script"
echo "======================================"

# 1. Fix content structure + front matter
echo "Step 1: Fixing content structure..."

mkdir -p content

FILES=("linux.md" "git.md" "docker.md" "cicd.md" "cloud.md" "kubernetes.md" "terraform.md" "ansible.md" "scenarios.md")

for f in "${FILES[@]}"; do
  if [ -f "$f" ]; then
    slug="${f%.md}"
    mkdir -p "content/$slug"
    git mv "$f" "content/$slug/index.md"

    title="$(echo "$slug" | sed -E 's/-/ /g' | sed -E 's/\b(.)/\u\1/g')"

    cat > "content/$slug/index.md".tmp <<EOF
---
title: "$title"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
draft: false
---

$(cat "content/$slug/index.md")
EOF

    mv "content/$slug/index.md".tmp "content/$slug/index.md"
  fi
done

git add .
git commit -m "Fix Hugo content structure and front matter" || true

# 2. Initialize theme submodule
echo "Step 2: Initializing PaperMod theme..."
git submodule update --init --recursive

git add .
git commit -m "Initialize PaperMod theme" || true

# 3. Add GitHub Pages workflow
echo "Step 3: Adding GitHub Pages workflow..."

mkdir -p .github/workflows

cat > .github/workflows/hugo-deploy.yml <<'EOF'
name: Build and deploy Hugo site to GitHub Pages

on:
  push:
    branches:
      - main

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4
        with:
          submodules: recursive

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true

      - name: Build
        run: hugo --minify

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages

    steps:
      - name: Deploy
        uses: actions/deploy-pages@v4
EOF

git add .github/workflows/hugo-deploy.yml
git commit -m "Add Hugo GitHub Pages deployment workflow" || true

# 4. Push everything
echo "Step 4: Pushing changes to GitHub..."
git push

echo "======================================"
echo " DONE! Now run:"
echo " hugo server -D"
echo "======================================"
