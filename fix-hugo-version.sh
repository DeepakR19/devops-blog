#!/usr/bin/env bash
set -e

echo "======================================"
echo " Fixing Hugo Version (PaperMod Safe)"
echo "======================================"

TARGET_VERSION="0.125.7"

echo "Pinning Hugo version to $TARGET_VERSION in GitHub Actions..."

WORKFLOW=".github/workflows/hugo-deploy.yml"

if [ -f "$WORKFLOW" ]; then
  sed -i.bak "s/hugo-version: .*/hugo-version: '$TARGET_VERSION'/" "$WORKFLOW"
else
  echo "ERROR: Workflow file not found: $WORKFLOW"
  exit 1
fi

git add "$WORKFLOW"
git commit -m "Pin Hugo version to $TARGET_VERSION for stability" || true

echo "--------------------------------------"
echo "Now install Hugo $TARGET_VERSION locally"
echo "--------------------------------------"

OS="$(uname -s)"

if [[ "$OS" == "Linux" ]]; then
  echo "Detected Linux"
  wget -q https://github.com/gohugoio/hugo/releases/download/v$TARGET_VERSION/hugo_extended_${TARGET_VERSION}_linux-amd64.tar.gz
  tar -xzf hugo_extended_${TARGET_VERSION}_linux-amd64.tar.gz
  sudo mv hugo /usr/local/bin/hugo
elif [[ "$OS" == "Darwin" ]]; then
  echo "Detected macOS"
  brew install hugo@0.125 || brew upgrade hugo@0.125
else
  echo "Detected Windows or unknown OS."
  echo "Please manually download:"
  echo "https://github.com/gohugoio/hugo/releases/download/v$TARGET_VERSION/hugo_extended_${TARGET_VERSION}_windows-amd64.zip"
fi

echo "--------------------------------------"
echo "Verifying Hugo version..."
hugo version || true

echo "--------------------------------------"
echo "Pushing changes..."
git push

echo "======================================"
echo " DONE. Now run:"
echo " hugo server -D"
echo "======================================"
