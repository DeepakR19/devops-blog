#!/usr/bin/env bash
set -e

echo "Upgrading UI to Premium Developer Dashboard..."

mkdir -p static/css static/js layouts/partials

cat > static/css/dashboard-premium.css <<'EOF'
/* Premium Dashboard Styles */
:root {
  --dash-bg: #0f172a;
  --dash-card: #111827;
  --dash-border: #1f2937;
  --dash-text: #e5e7eb;
  --dash-muted: #9ca3af;
  --dash-accent: #3b82f6;
}

.dashboard-topbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 60px;
  background: var(--dash-card);
  border-bottom: 1px solid var(--dash-border);
  display: flex;
  align-items: center;
  padding: 0 1.2rem;
  z-index: 1000;
}

.dashboard-brand {
  font-weight: 600;
  letter-spacing: 0.3px;
  color: var(--dash-text);
}

.dashboard-toggle {
  margin-right: 1rem;
  cursor: pointer;
  font-size: 20px;
  color: var(--dash-text);
}

.dashboard-sidebar {
  position: fixed;
  top: 60px; left: 0; bottom: 0;
  width: 260px;
  background: var(--dash-card);
  border-right: 1px solid var(--dash-border);
  padding: 1rem;
  transition: transform .25s ease;
  z-index: 999;
}

.dashboard-sidebar.collapsed {
  transform: translateX(-100%);
}

.dashboard-sidebar ul {
  list-style: none;
  padding: 0;
  margin: 1rem 0 0;
}

.dashboard-sidebar li {
  margin-bottom: .5rem;
}

.dashboard-sidebar a {
  color: var(--dash-text);
  text-decoration: none;
  padding: .6rem .75rem;
  display: block;
  border-radius: 8px;
}

.dashboard-sidebar a:hover {
  background: rgba(255,255,255,0.05);
}

.dashboard-main {
  margin-top: 60px;
  margin-left: 260px;
  padding: 2rem;
  transition: margin-left .25s ease;
}

.dashboard-main.full {
  margin-left: 0;
}

.dashboard-card {
  background: var(--dash-card);
  border: 1px solid var(--dash-border);
  border-radius: 12px;
  padding: 1.25rem;
  margin-bottom: 1rem;
  color: var(--dash-text);
}
EOF

cat > static/js/dashboard-premium.js <<'EOF'
document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("dash-toggle");
  const sidebar = document.getElementById("dash-sidebar");
  const main = document.getElementById("dash-main");

  if (!toggle || !sidebar || !main) return;

  toggle.addEventListener("click", function () {
    sidebar.classList.toggle("collapsed");
    main.classList.toggle("full");
  });
});
EOF

cat > layouts/partials/dashboard-premium.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-premium.css">
<script defer src="/js/dashboard-premium.js"></script>

<div class="dashboard-topbar">
  <span id="dash-toggle" class="dashboard-toggle">☰</span>
  <div class="dashboard-brand">DevOps Dashboard</div>
</div>

<div id="dash-sidebar" class="dashboard-sidebar">
  <ul>
    <li><a href="/">🏠 Home</a></li>
    <li><a href="/posts/">📝 Notes</a></li>
    <li><a href="/tags/">🏷 Tags</a></li>
  </ul>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
  const main = document.querySelector("main");
  if (main) {
    main.id = "dash-main";
    main.classList.add("dashboard-main");
  }
});
</script>
EOF

BASE="layouts/_default/baseof.html"
if grep -q "dashboard-premium" "$BASE"; then
  echo "Premium dashboard already injected."
else
  sed -i '/<body/ a {{ partial "dashboard-premium.html" . }}' "$BASE"
  echo "Injected premium dashboard into base layout."
fi

echo "Upgrade complete. Run: hugo server"

