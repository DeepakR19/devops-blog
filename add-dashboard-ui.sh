#!/usr/bin/env bash
set -e

echo "Adding Developer Dashboard UI..."

# Create dirs
mkdir -p static/css static/js layouts/partials

# CSS
cat > static/css/dashboard.css <<'EOF'
/* Dashboard Layout */
.dashboard-topbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 56px;
  background: var(--theme);
  display: flex;
  align-items: center;
  padding: 0 1rem;
  z-index: 1000;
  border-bottom: 1px solid var(--border);
}
.dashboard-sidebar {
  position: fixed;
  top: 56px; left: 0;
  width: 240px;
  bottom: 0;
  background: var(--theme);
  border-right: 1px solid var(--border);
  padding: 1rem;
  transform: translateX(0);
  transition: transform .2s ease;
  z-index: 999;
}
.dashboard-sidebar.collapsed {
  transform: translateX(-100%);
}
.dashboard-main {
  margin-top: 56px;
  margin-left: 240px;
  padding: 2rem;
  transition: margin-left .2s ease;
}
.dashboard-main.full {
  margin-left: 0;
}
.dashboard-toggle {
  cursor: pointer;
  font-size: 20px;
  margin-right: 1rem;
}
EOF

# JS
cat > static/js/dashboard.js <<'EOF'
document.addEventListener("DOMContentLoaded", function () {
  const toggle = document.getElementById("dash-toggle");
  const sidebar = document.getElementById("dash-sidebar");
  const main = document.getElementById("dash-main");

  if (!toggle) return;

  toggle.addEventListener("click", function () {
    sidebar.classList.toggle("collapsed");
    main.classList.toggle("full");
  });
});
EOF

# Partial
cat > layouts/partials/dashboard.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard.css">
<script defer src="/js/dashboard.js"></script>

<div class="dashboard-topbar">
  <span id="dash-toggle" class="dashboard-toggle">☰</span>
  <strong>DevOps Dashboard</strong>
</div>

<div id="dash-sidebar" class="dashboard-sidebar">
  <p><strong>Navigation</strong></p>
  <ul>
    <li><a href="/">Home</a></li>
    <li><a href="/posts/">Posts</a></li>
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

# Inject into baseof.html
BASE="layouts/_default/baseof.html"
if grep -q "dashboard-topbar" "$BASE"; then
  echo "Dashboard already injected."
else
  sed -i '/<body/ a {{ partial "dashboard.html" . }}' "$BASE"
  echo "Injected dashboard into base layout."
fi

echo "Done. Run: hugo server"
