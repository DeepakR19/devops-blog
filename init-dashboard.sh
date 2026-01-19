#!/bin/bash

echo "Applying Phase H2 — Perfect Homepage Hero Centering..."

CSS="static/css/main.css"

cp $CSS ${CSS}.bak_home_perfect_center

cat <<'EOF' >> $CSS

/* ================================
   Phase H2 — Perfect Homepage Center
   ================================ */

/* Homepage only */
body.home .hero {
  min-height: calc(100vh - 90px) !important; /* icon header height */
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  padding-top: 0 !important;
  padding-bottom: 0 !important;
}

/* Lock content to true vertical center */
body.home .hero-content {
  transform: translateY(-50%) !important;
  position: relative;
  top: 50%;
}

/* Ensure text remains centered */
body.home .hero-content * {
  text-align: center;
}

EOF

echo "Phase H2 applied. Restart Hugo."
