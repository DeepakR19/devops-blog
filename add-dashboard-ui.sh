#!/usr/bin/env bash
set -e

echo "🔥 FINAL CLEAN REBUILD — wiping all custom UI"

# Safety check
if [ ! -f "hugo.toml" ]; then
  echo "❌ Run this from Hugo project root"
  exit 1
fi

# 1. Remove all UI overrides
rm -rf layouts/_default
rm -rf layouts/partials
rm -f layouts/index.html
rm -f static/css/dashboard*.css
rm -f static/js/dashboard*.js

# 2. Clear public output
rm -rf public

# 3. Recreate needed folders
mkdir -p layouts/partials
mkdir -p layouts/_default
mkdir -p static/css

# 4. Add clean dashboard CSS
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
  text-decoration: none;
  color: var(--primary);
  display: block;
  transition: transform 0.15s ease, box-shadow 0.15s ease;
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

# 5. Hook CSS safely
cat > layouts/partials/extend_head.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-clean.css">
EOF

# 6. Override real homepage (correct Hugo logic)
cat > layouts/_default/home.html <<'EOF'
{{ define "main" }}
<div class="page-header">
  <h1>DevOps Knowledge Hub</h1>
  <p>Notes, references, and real-world DevOps learning.</p>
</div>

<div class="dashboard-grid">
  <a class="dashboard-card" href="/linux/"><h3>🐧 Linux</h3><p>Explore Linux notes</p></a>
  <a class="dashboard-card" href="/git/"><h3>🌱 Git</h3><p>Explore Git notes</p></a>
  <a class="dashboard-card" href="/cicd/"><h3>🔁 CI/CD</h3><p>Explore CI/CD notes</p></a>
  <a class="dashboard-card" href="/cloud/"><h3>☁️ Cloud</h3><p>Explore Cloud notes</p></a>
  <a class="dashboard-card" href="/docker/"><h3>🐳 Docker</h3><p>Explore Docker notes</p></a>
  <a class="dashboard-card" href="/kubernetes/"><h3>☸️ Kubernetes</h3><p>Explore Kubernetes notes</p></a>
  <a class="dashboard-card" href="/terraform/"><h3>🏗 Terraform</h3><p>Explore Terraform notes</p></a>
  <a class="dashboard-card" href="/ansible/"><h3>⚙️ Ansible</h3><p>Explore Ansible notes</p></a>
</div>
{{ end }}
EOF

echo "✅ CLEAN REBUILD COMPLETE"
echo ""
echo "Now run:"
echo "hugo server --disableFastRender"
echo ""
echo "Then HARD refresh:"
echo "Ctrl + Shift + R"

