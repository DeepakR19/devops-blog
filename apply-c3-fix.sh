#!/bin/bash

set -e

echo "🔧 Applying C3 Fix: Breadcrumbs + Spacing + Nav Flow"

# 1. Create breadcrumb partial
mkdir -p layouts/partials

cat > layouts/partials/breadcrumbs.html << 'HTML'
{{ if not .IsHome }}
<nav class="breadcrumbs">
  <a href="/">Home</a>
  {{ range .CurrentSection.Sections }}
    › <a href="{{ .RelPermalink }}">{{ .Title }}</a>
  {{ end }}
  › <span>{{ .Title }}</span>
</nav>
{{ end }}
HTML

echo "✅ Breadcrumb partial created"

# 2. Inject breadcrumbs into base layout
if ! grep -q 'breadcrumbs.html' layouts/_default/baseof.html; then
  sed -i '/topnav.html/a \  {{ partial "breadcrumbs.html" . }}' layouts/_default/baseof.html
  echo "✅ Breadcrumbs injected into baseof.html"
fi

# 3. Add breadcrumb styles
cat >> static/css/section.css << 'CSS'

/* ===== Breadcrumbs ===== */

.breadcrumbs {
  max-width: 1100px;
  margin: 1.5rem auto 0;
  padding: 0 2rem;
  font-size: 0.85rem;
  color: rgba(255,255,255,0.5);
}

.breadcrumbs a {
  color: rgba(255,255,255,0.7);
  text-decoration: none;
}

.breadcrumbs a:hover {
  color: #fff;
}

/* Fix spacing under nav */
body.section .section-hero {
  margin-top: 3rem;
