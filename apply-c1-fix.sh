#!/bin/bash

set -e

echo "🔧 Applying C1 Fix: Section Pages Matte Layout"

# 1. Restore known good list.html
if [ -f layouts/_default/list.html.bak_c1 ]; then
  cp layouts/_default/list.html.bak_c1 layouts/_default/list.html
  echo "✅ Restored list.html from bak_c1"
else
  echo "❌ layouts/_default/list.html.bak_c1 not found"
  exit 1
fi

# 2. Ensure section.css exists
if [ ! -f static/css/section.css ]; then
  cat > static/css/section.css << 'CSS'
body.section-page {
  background: radial-gradient(circle at top, #0f172a, #020617);
  color: #e5e7eb;
}

.section-hero {
  min-height: 70vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.section-glass {
  background: rgba(15, 23, 42, 0.6);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-radius: 18px;
  padding: 3rem 4rem;
  max-width: 900px;
  width: 90%;
  text-align: center;
  box-shadow: 0 0 0 1px rgba(255,255,255,0.06),
              0 40px 80px rgba(0,0,0,0.5);
}

.section-title {
  font-size: 3rem;
  font-weight: 700;
  letter-spacing: -0.03em;
}

.section-subtitle {
  opacity: 0.75;
  margin-top: 1rem;
}
CSS
  echo "✅ Created section.css"
else
  echo "ℹ️ section.css already exists"
fi

# 3. Inject section CSS into baseof.html if missing
if ! grep -q "section.css" layouts/_default/baseof.html; then
  sed -i '/main.css/a \  <link rel="stylesheet" href="/css/section.css">' layouts/_default/baseof.html
  echo "✅ Injected section.css into baseof.html"
fi

# 4. Add body class hook for section pages
if ! grep -q "body class" layouts/_default/list.html; then
  sed -i '1s|^|{{ define "main" }}\n<div class="section-page">\n|' layouts/_default/list.html
  echo "⚠️ Wrapped section layout"
fi

# 5. Hugo rebuild reminder
echo ""
echo "🚀 C1 Fix Applied"
echo "Now run:"
echo "    hugo server -D"
echo ""
