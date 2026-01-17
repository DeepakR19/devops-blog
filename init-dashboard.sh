#!/bin/bash
set -e

echo "Installing Homepage Phase H4: Polish + Stats + CTA"

# ---------------------------
# Update homepage layout
# ---------------------------
cat > layouts/index.html << 'EOF'
{{ define "main" }}

<section class="hero">
  <h1 class="hero-title">DevOps Knowledge Hub</h1>
  <p class="hero-subtitle">
    Real-world Linux, Docker, Kubernetes, Cloud & CI/CD — documented as I learn.
  </p>

  <div class="hero-actions">
    <a href="/linux/" class="btn primary">Start Learning</a>
    <a href="https://github.com/" class="btn secondary">GitHub</a>
  </div>
</section>

<section class="hero-divider"></section>

<section class="card-section">
  <div class="card-grid modern">
    <a href="/linux/" class="card modern">
      <div class="card-icon">🐧</div>
      <div class="card-title">Linux</div>
      <div class="card-desc">Commands, internals, debugging</div>
    </a>

    <a href="/docker/" class="card modern">
      <div class="card-icon">🐳</div>
      <div class="card-title">Docker</div>
      <div class="card-desc">Containers, images, networking</div>
    </a>

    <a href="/kubernetes/" class="card modern">
      <div class="card-icon">☸</div>
      <div class="card-title">Kubernetes</div>
      <div class="card-desc">Pods, services, scaling</div>
    </a>

    <a href="/cloud/" class="card modern">
      <div class="card-icon">☁️</div>
      <div class="card-title">Cloud</div>
      <div class="card-desc">AWS, Azure, GCP</div>
    </a>

    <a href="/cicd/" class="card modern">
      <div class="card-icon">🔁</div>
      <div class="card-title">CI/CD</div>
      <div class="card-desc">Pipelines & automation</div>
    </a>

    <a href="/terraform/" class="card modern">
      <div class="card-icon">🏗</div>
      <div class="card-title">Terraform</div>
      <div class="card-desc">Infrastructure as Code</div>
    </a>
  </div>
</section>

<section class="identity-section">
  <div class="identity-inner">
    <h2>This is not a tutorial site.</h2>
    <p>This is my DevOps brain — organized.</p>
    <p>
      Everything here comes from real problems, real debugging, real mistakes,
      and real fixes. I document what I learn so I never forget — and so others
      can learn from it too.
    </p>
  </div>
</section>

<section class="stats-section">
  <div class="stats-grid">
    <div class="stat">
      <div class="stat-number">100+</div>
      <div class="stat-label">Commands</div>
    </div>
    <div class="stat">
      <div class="stat-number">50+</div>
      <div class="stat-label">Guides</div>
    </div>
    <div class="stat">
      <div class="stat-number">20+</div>
      <div class="stat-label">Scenarios</div>
    </div>
    <div class="stat">
      <div class="stat-number">Weekly</div>
      <div class="stat-label">Updates</div>
    </div>
  </div>
</section>

<section class="final-cta">
  <h2>Start exploring</h2>
  <p>Pick a topic and dive in.</p>
  <div class="hero-actions">
    <a href="/linux/" class="btn primary">Linux</a>
    <a href="/docker/" class="btn secondary">Docker</a>
    <a href="/kubernetes/" class="btn secondary">Kubernetes</a>
  </div>
</section>

{{ end }}
EOF

# ---------------------------
# Polish CSS
# ---------------------------
cat >> static/css/main.css << 'EOF'

/* Homepage H4 — Stats */

.stats-section {
  max-width: 900px;
  margin: 0 auto;
  padding: 40px 24px 120px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
  gap: 24px;
  text-align: center;
}

.stat {
  background: var(--card-bg);
  border: 1px solid var(--border);
  border-radius: 18px;
  padding: 24px;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
}

.stat-number {
  font-size: 1.6rem;
  font-weight: 700;
}

.stat-label {
  font-size: 0.9rem;
  opacity: 0.7;
}

/* Final CTA */

.final-cta {
  max-width: 800px;
  margin: 0 auto;
  padding: 0 24px 120px;
  text-align: center;
}

.final-cta h2 {
  font-size: 2rem;
  margin-bottom: 8px;
}

.final-cta p {
  opacity: 0.7;
  margin-bottom: 24px;
}
EOF

echo "Homepage Phase H4 installed."
echo "Restart Hugo: hugo server --disableFastRender"
