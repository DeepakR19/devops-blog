#!/usr/bin/env bash
set -e

SECTIONS=(linux git cicd cloud docker kubernetes terraform ansible scenarios)

for s in "${SECTIONS[@]}"; do
  mkdir -p "content/$s"

  if [ ! -f "content/$s/_index.md" ]; then
    cat > "content/$s/_index.md" <<EOF
---
title: "$(echo $s | sed -E 's/\b(.)/\u\1/g')"
draft: false
---

# $(echo $s | sed -E 's/\b(.)/\u\1/g')

Welcome to the $s section.
EOF
  else
    sed -i 's/draft: true/draft: false/g' "content/$s/_index.md" || true
  fi
done

echo "All section pages fixed."

