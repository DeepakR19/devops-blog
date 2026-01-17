#!/usr/bin/env bash
set -e

echo "=== FINAL STABLE RESET + DASHBOARD SETUP ==="

# 1. Remove all previous broken overrides
rm -f static/css/dashboard-*.css
rm -f static/js/dashboard-*.js
rm -f layouts/partials/extend_head.html
rm -f layouts/partials/extend_body.html
rm -f layouts/partials/extend_footer.html
rm -f layouts/_default/baseof.html

# 2. Ensure folders exist
mkdir -p static/css layouts/partials

# 3. Clean dashboard CSS (PaperMod safe)
cat > static/css/dashboard-clean.css <<'EOF'
.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.dashboard-card {
  background: var(--entry);
  border: 1px solid var(--border);
  border-radius: 14px;
  padding: 1.25rem;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
  text-decoration: none;
  color: var(--primary);
  display: block;
}

.dashboard-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.08);
}

.dashboard-card h3 {
  margin: 0 0 0.25rem 0;
}

.dashboard-card p {
  color: var(--secondary);
  font-size: 0.95rem;
}
EOF

# 4. Hook CSS safely
cat > layouts/partials/extend_head.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-clean.css">
EOF

# 5. Create clean dashboard homepage
cat > layouts/index.html <<'EOF'
{{ define "main" }}
<div class="page-header">
  <h1>DevOps Knowledge Hub</h1>
  <p>Notes, references, and real-world DevOps learning.</p>
</div>

<div class="dashboard-grid">
  <a class="dashboard-card" href="/linux/">
    <h3>🐧 Linux</h3>
    <p>Explore Linux notes</p>
  </a>
  <a class="dashboard-card" href="/git/">
    <h3>🌱 Git</h3>
    <p>Explore Git notes</p>
  </a>
  <a class="dashboard-card" href="/cicd/">
    <h3>🔁 CI/CD</h3>
    <p>Explore CI/CD notes</p>
  </a>
  <a class="dashboard-card" href="/cloud/">
    <h3>☁️ Cloud</h3>
    <p>Explore Cloud notes</p>
  </a>
  <a class="dashboard-card" href="/docker/">
    <h3>🐳 Docker</h3>
    <p>Explore Docker notes</p>
  </a>
  <a class="dashboard-card" href="/kubernetes/">
    <h3>☸️ Kubernetes</h3>
    <p>Explore Kubernetes notes</p>
  </a>
  <a class="dashboard-card" href="/terraform/">
    <h3>🏗 Terraform</h3>
    <p>Explore Terraform notes</p>
  </a>
  <a class="dashboard-card" href="/ansible/">
    <h3>⚙️ Ansible</h3>
    <p>Explore Ansible notes</p>
  </a>
</div>
{{ end }}
EOF

echo "=== DONE ==="
echo ""
echo "Now run:"
echo "  hugo server --disableFastRender"
echo ""
echo "Then HARD refresh:"
echo "  Ctrl + Shift + R"

