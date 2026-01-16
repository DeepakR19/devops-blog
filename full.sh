#!/usr/bin/env bash
set -e

echo "======================================"
echo " Hugo + PaperMod Full Auto Fix"
echo "======================================"

### 1. Fix Hugo version in workflow
WORKFLOW=".github/workflows/hugo-deploy.yml"

echo "Fixing Hugo version in workflow..."
sed -i.bak "s/hugo-version: .*/hugo-version: '0.154.5'/" "$WORKFLOW"

### 2. Fix frontmatter crashes
echo "Fixing frontmatter..."

find content -name "_index.md" | while read f; do
  sed -i 's/{{.*}}//g' "$f"
  sed -i 's/draft: true/draft: false/g' "$f"

  if ! grep -q "^title:" "$f"; then
    title=$(basename "$(dirname "$f")" | sed -E 's/-/ /g' | sed -E 's/\b(.)/\u\1/g')
    sed -i "1i---\ntitle: \"$title\"\ndraft: false\n---\n" "$f"
  fi
done

### 3. Force section pages (fix 404)
echo "Fixing section routing..."

SECTIONS=(linux git cicd cloud docker kubernetes terraform ansible scenarios)

for s in "${SECTIONS[@]}"; do
  mkdir -p "content/$s"

  if [ -f "content/$s/index.md" ]; then
    mv "content/$s/index.md" "content/$s/_index.md"
  fi

  if [ ! -f "content/$s/_index.md" ]; then
    cat > "content/$s/_index.md" <<EOF
---
title: "$(echo $s | sed -E 's/\b(.)/\u\1/g')"
draft: false
---

# $(echo $s | sed -E 's/\b(.)/\u\1/g')

Welcome to the $s section.
EOF
  fi

  sed -i 's/draft: true/draft: false/g' "content/$s/_index.md" || true
done

### 4. Remove public folder (GitHub Actions rebuilds it)
echo "Cleaning public/ folder..."

rm -rf public
grep -qxF "public/" .gitignore || echo "public/" >> .gitignore

### 5. Commit and push everything
echo "Committing changes..."

git add .
git commit -m "Full Hugo + PaperMod auto-fix" || true
git push

echo "======================================"
echo " DONE!"
echo " Now wait for GitHub Actions to finish."
echo "======================================"

