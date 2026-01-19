#!/bin/bash
set -e

CSS="static/css/main.css"

echo "Backing up CSS..."
cp "$CSS" "$CSS.bak_ultrawide_glass"

echo "Applying ultra-wide canvas + glass notebook..."

cat >> "$CSS" <<'CSS'

/* ===============================
   Ultra-Wide Canvas + Glass Panel
   =============================== */

.section-reading-content {
  width: 100vw !important;
  max-width: none !important;
  margin: 0 !important;
  padding: 3rem 6vw !important;
  display: flex;
  justify-content: center;
}

.section-reading-content > * {
  width: 100%;
  max-width: 1400px;
}

.section-reading-content::before {
  content: "";
  position: absolute;
  inset: 0;
}

/* Glass notebook surface */
.section-reading-content > div,
.section-reading-content > article,
.section-reading-content > .glass-panel {
  background: linear-gradient(
    180deg,
    rgba(255,255,255,0.06),
    rgba(255,255,255,0.02)
  );
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 18px;
  padding: 3rem 3rem;
  box-shadow: 0 20px 60px rgba(0,0,0,0.35);
}

CSS

echo "Ultra-wide + glass applied."
echo "Restart Hugo + hard refresh (Ctrl+Shift+R)."
