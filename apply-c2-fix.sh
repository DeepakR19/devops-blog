#!/bin/bash

set -e

echo "🔧 Applying C2 Fix: Section Page Structure + Layout"

# 1. Replace list.html with real layout
cat > layouts/_default/list.html << 'HTML'
{{ define "main" }}

<section class="section-hero">
  <div class="section-glass">
    <h1 class="section-title">{{ .Title }}</h1>
    {{ with .Params.description }}
      <p class="section-subtitle">{{ . }}</p>
    {{ else }}
      <p class="section-subtitle">Explore curated content on {{ .Title }}.</p>
    {{ end }}
  </div>
</section>

<section class="section-content">
  <div class="section-container">
    <div class="post-grid">
      {{ range .Pages }}
        <a href="{{ .RelPermalink }}" class="post-card">
          <h3>{{ .Title }}</h3>
          {{ with .Params.description }}
            <p>{{ . }}</p>
          {{ end }}
        </a>
      {{ end }}
    </div>
  </div>
</section>

{{ end }}
HTML

echo "✅ list.html rebuilt"

# 2. Add C2 styles
cat >> static/css/section.css << 'CSS'

.section-content {
  padding: 6rem 2rem;
}

.section-container {
  max-width: 1100px;
  margin: 0 auto;
}

.post-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 2rem;
}

.post-card {
  background: rgba(15, 23, 42, 0.5);
  backdrop-filter: blur(12px);
  border-radius: 14px;
  padding: 1.5rem;
  color: #e5e7eb;
  text-decoration: none;
  box-shadow: 0 0 0 1px rgba(255,255,255,0.05),
              0 20px 40px rgba(0,0,0,0.4);
  transition: transform .2s ease, box-shadow .2s ease;
}

.post-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 0 0 1px rgba(255,255,255,0.08),
              0 30px 60px rgba(0,0,0,0.6);
}

.post-card h3 {
  margin: 0 0 .5rem;
}

.post-card p {
  opacity: .7;
  font-size: .95rem;
}
CSS

echo "✅ Section grid styles added"

echo ""
echo "🚀 C2 Applied"
echo "Restart Hugo:"
echo "    hugo server -D"
echo ""

