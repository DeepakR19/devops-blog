#!/bin/bash
set -e

echo "Installing H6-TUNED polish"

cat >> static/css/main.css << 'EOF'

/* ============================
   H6 — TUNED POLISH
   ============================ */

/* Better text color system */
:root {
  --text-main: #0f172a;      /* soft charcoal */
  --text-muted: #475569;     /* slate */
}

body.dark {
  --text-main: #e5e7eb;      /* soft white */
  --text-muted: #94a3b8;     /* muted gray */
}

body {
  color: var(--text-main);
}

/* Headings stronger */
h1, h2, h3 {
  letter-spacing: -0.03em;
}

/* Hero impact boost */
.hero-title {
  font-size: 3.3rem;
  font-weight: 700;
}

.hero-subtitle {
  color: var(--text-muted);
  font-size: 1.25rem;
}

/* Hero glow refined */
.hero::after {
  content: "";
  position: absolute;
  inset: -60px;
  background:
    radial-gradient(60% 40% at 50% 0%, rgba(99,102,241,0.18), transparent 65%);
  filter: blur(80px);
  z-index: -1;
}

body.dark .hero::after {
  background:
    radial-gradient(60% 40% at 50% 0%, rgba(56,189,248,0.18), transparent 65%);
}

/* Section continuity */
.card-section,
.identity-section,
.stats-section {
  position: relative;
}

.card-section::before,
.identity-section::before,
.stats-section::before {
  content: "";
  position: absolute;
  inset: -40px 0;
  background: linear-gradient(
    to bottom,
    transparent,
    rgba(0,0,0,0.035),
    transparent
  );
  pointer-events: none;
}

body.dark .card-section::before,
body.dark .identity-section::before,
body.dark .stats-section::before {
  background: linear-gradient(
    to bottom,
    transparent,
    rgba(255,255,255,0.04),
    transparent
  );
}

/* Cards: more pop */
.card.modern {
  box-shadow: 0 14px 36px rgba(0,0,0,0.18);
  border: 1px solid rgba(0,0,0,0.08);
}

body.dark .card.modern {
  border: 1px solid rgba(255,255,255,0.08);
}

.card.modern:hover {
  transform: translateY(-8px);
  box-shadow: 0 28px 60px rgba(0,0,0,0.25);
}

/* Identity text color */
.identity-inner p {
  color: var(--text-muted);
}

/* Stats pop */
.stat-number {
  font-weight: 800;
  letter-spacing: -0.02em;
}

/* CTA more authority */
.final-cta h2 {
  font-size: 2.2rem;
}

.final-cta p {
  color: var(--text-muted);
}

/* Improved section rhythm */
.card-section { padding-top: 120px; }
.identity-section { padding-top: 120px; }
.stats-section { padding-top: 80px; }
.final-cta { padding-top: 100px; }

EOF

echo "H6-TUNED installed."
echo "Restart Hugo: hugo server --disableFastRender"
