#!/bin/bash
set -e

CSS="static/css/main.css"

echo "Backing up CSS..."
cp "$CSS" "$CSS.bak_before_A1_fix"

echo "Removing old width rules..."
sed -i '/section-reading-content/,+6d' "$CSS"

echo "Applying A1 full-width layout..."

cat >> "$CSS" <<'CSS'

/* ===============================
   Phase A1 — Full-width Workspace
   =============================== */

.section-reading-content {
  width: 96vw;
  max-width: 1800px;
  margin: 0 auto;
  padding: 3rem 3rem;
}

CSS

echo "A1 width fix applied."
