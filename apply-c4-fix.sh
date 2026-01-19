#!/bin/bash
set -e

echo "🔧 Applying C4 Fix: Spacing + Layout Stability"

# 1. Add spacing fixes to section.css
cat >> static/css/section.css << 'CSS'

/* ===== C4: Layout Stability ===== */

/* Prevent nav overlap */
body.section main {
  padding-top: 4rem;
}

/* Normalize section hero spacing */
.section-hero {
  padding-top: 4rem;
  padding-bottom: 4rem;
}

/* Normalize content spacing */
.section-content {
  padding-top: 3rem;
  padding-bottom: 6rem;
}

/* Width rhythm */
.section-container,
.section-glass,
.post-grid {
  max-width: 1100px;
  margin-left: auto;
  margin-right: auto;
}

/* Footer spacing safety */
footer {
  margin-top: 6rem;
}

/* Mobile safety */
@media (max-width: 768px) {
  .section-hero {
    padding: 3rem 1.5rem;
  }

  .section-content {
    padding: 3rem 1.5rem;
  }

  .post-grid {
    grid-template-columns: 1fr;
  }
}
CSS

echo "✅ Layout stability styles added"

echo ""
echo "🚀 C4 Applied"
echo "Restart Hugo:"
echo "    hugo server -D"
echo ""

