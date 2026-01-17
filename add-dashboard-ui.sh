#!/usr/bin/env bash
set -e

echo "Applying corrected DevOps dashboard UI..."

mkdir -p static/css static/js layouts/partials

# ---------------- CSS ----------------
cat > static/css/dashboard-fixed.css <<'EOF'
:root {
  --dash-bg: var(--theme);
  --dash-card: var(--entry);
  --dash-border: var(--border);
  --dash-text: var(--primary);
  --dash-muted: var(--secondary);
  --dash-accent: var(--link-color);
}

.dashboard-topbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 56px;
  background: var(--dash-bg);
  border-bottom: 1px solid var(--dash-border);
  display: flex;
  align-items: center;
  padding: 0 1rem;
  z-index: 10000;
}

.dashboard-toggle {
  font-size: 20px;
  cursor: pointer;
  margin-right: 1rem;
  color: var(--dash-text);
}

.dashboard-brand {
  font-weight: 600;
  color: var(--dash-text);
}

.dashboard-sidebar {
  position: fixed;
  top: 56px;
  left: 0;
  bottom: 0;
  width: 260px;
  background: var(--dash-bg);
  border-right: 1px solid var(--dash-border);
  padding: 1rem;
  transition: transform 0.25s ease;
  z-index: 9999;
}

.dashboard-sidebar.collapsed {
  transform: translateX(-100%);
}

.dashboard-sidebar a {
  display: block;
  padding: 0.6rem 0.75rem;
  border-radius: 8px;
  color: var(--dash-text);
  text-decoration: none;
}

.dashboard-sidebar a:hover {
  background: var(--dash-card);
}

.dashboard-main {
  margin-top: 56px;
  margin-left: 260px;
  padding: 2rem;
  transition: margin-left 0.25s ease;
  max-width: 100%;
}

.dashboard-main.full {
  margin-left: 0;
}

/* Fix PaperMod container conflicts */
.main {
  max-width: 100% !important;
  padding-left: 0 !important;
  padding-right: 0 !important;
}
EOF

# ---------------- JS ----------------
cat > static/js/dashboard-fixed.js <<'EOF'
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

# ---------------- HEAD HOOK ----------------
cat > layouts/partials/extend_head.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-fixed.css">
<script defer src="/js/dashboard-fixed.js"></script>
EOF

# ---------------- BODY HOOK ----------------
cat > layouts/partials/extend_body.html <<'EOF'
<div class="dashboard-topbar">
  <span id="dash-toggle" class="dashboard-toggle">☰</span>
  <div class="dashboard-brand">DevOps Dashboard</div>
</div>

<div id="dash-sidebar" class="dashboard-sidebar">
  <a href="/">🏠 Home</a>
  <a href="/posts/">📝 Notes</a>
  <a href="/tags/">🏷 Tags</a>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const main = document.querySelector("main");
  if (main) {
    main.id = "dash-main";
    main.classList.add("dashboard-main");
  }
});
</script>
EOF

echo "✅ Dashboard fixes applied."
echo "Now run: hugo server --disableFastRender"
echo "Then hard refresh: Ctrl + Shift + R"

