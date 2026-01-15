#!/usr/bin/env bash
set -euo pipefail

# Migration script:
# - Back up listed markdown files to backup/original_files_<timestamp>
# - Create content/<slug>/index.md with YAML front matter (title, date, draft=false)
# - Preserve content (removes any existing front matter blocks)
# - Stages new files and removes originals from git (so commit will include the migration)

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
backup_dir="backup/original_files_${timestamp}"
mkdir -p "$backup_dir"

files=(linux.md git.md docker.md cicd.md cloud.md kubernetes.md terraform.md ansible.md scenarios.md)

for f in "${files[@]}"; do
  if [ -f "$f" ]; then
    echo "Processing $f..."
    cp "$f" "$backup_dir/"

    slug="${f%.md}"
dest_dir="content/$slug"
mkdir -p "$dest_dir"

    # Create a human-friendly title from the filename (replace hyphens with spaces and title-case)
title="$(echo "$slug" | sed -E 's/-/ /g' | sed -E 's/(^| )(.)/\\1\u\2/g')"

    # Extract content after front matter (if any). This keeps entire file if no front matter present.
    # This awk treats the first '---' .. next '---' block as front matter and strips it.
    body="$(awk 'BEGIN{p=1} /^---/{if(p==1){p=0;next}else{p=1;next}} p==1{print}' "$f")"

    cat > "$dest_dir/index.md" <<EOF
---
title: "$title"
date: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
draft: false
tags:
- $(echo "$slug" | tr '[:upper:]' '[:lower:]')
categories:
- $(echo "$slug" | tr '[:upper:]' '[:lower:]')
---

$body
EOF

    # Stage and remove original file so commit shows the migration
git add "$dest_dir/index.md"
git rm -f "$f" || true

    echo "Moved $f -> $dest_dir/index.md (backup at $backup_dir/$f)"
  else
    echo "Skipping $f (not present)"
  fi
 done

 echo "Migration preparation complete. Backup saved to: $backup_dir"
echo "Run: git commit -m \"migrate: move markdown into content/ and add front matter\""