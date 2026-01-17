#!/usr/bin/env bash
set -e

echo "Applying SAFE DevOps dashboard UI (PaperMod compatible)..."

mkdir -p static/css static/js layouts/partials

# =========================
# CSS
# =========================
cat > static/css/dashboard-safe.css <<'EOF'
/* Dashboard topbar */
.dashboard-topbar {
  position: sticky;
  top: 0;
  z-index: 9999;
  height: 56px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 1rem;
  background: var(--theme);
  border-bottom: 1px solid var(--border);
}

.dashboard-left {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.dashboard-toggle {
  cursor: pointer;
  font-size: 20px;
}

.dashboard-brand {
  font-weight: 600;
}

.dashboard-theme-btn {
  cursor: pointer;
  border: 1px solid var(--border);
  padding: 4px 10px;
  border-radius: 8px;
  background: var(--entry);
}

/* Sidebar (non-destructive) */
.dashboard-sidebar {
  position: fixed;
  top: 56px;
  left: 0;
  bottom: 0;
  width: 220px;
  padding: 1rem;
  background: var(--theme);
  border-right: 1px solid var(--border);
  transform: translateX(0);
  transition: transform 0.2s ease;
  z-index: 9998;
}

.dashboard-sidebar.collapsed {
  transform: translateX(-100%);
}

.dashboard-sidebar a {
  display: block;
  padding: 0.5rem 0.75rem;
  border-radius: 6px;
  color: var(--primary);
  text-decoration: none;
}

.dashboard-sidebar a:hover {
  background: var(--entry);
}

/* Content offset (non-destructive) */
body.dashboard-active main {
  margin-left: 220px;
  transition: margin-left 0.2s ease;
}

body.dashboard-active.sidebar-collapsed main {
  margin-left: 0;
}
EOF

# =========================
# JS
# =========================
cat > static/js/dashboard-safe.js <<'EOF'
document.addEventListener("DOMContentLoaded", function () {
  const sidebarToggle = document.getElementById("dash-toggle");
  const sidebar = document.getElementById("dash-sidebar");
  const themeBtn = document.getElementById("dash-theme-btn");

  document.body.classList.add("dashboard-active");

  if (sidebarToggle && sidebar) {
    sidebarToggle.addEventListener("click", function () {
      sidebar.classList.toggle("collapsed");
      document.body.classList.toggle("sidebar-collapsed");
    });
  }

  // Hook into PaperMod's real theme toggle
  if (themeBtn) {
    themeBtn.addEventListener("click", function () {
      const realToggle = document.querySelector(".theme-toggle");
      if (realToggle) {
        realToggle.click(); // Let PaperMod handle everything
      }
    });
  }

  // Hide original toggle visually (but keep it functional)
  const originalToggle = document.querySelector(".theme-toggle");
  if (originalToggle) {
    originalToggle.style.opacity = "0";
    originalToggle.style.pointerEvents = "none";
    originalToggle.style.height = "0";
  }
});
EOF

# =========================
# Head Hook
# =========================
cat > layouts/partials/extend_head.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-safe.css">
<script defer src="/js/dashboard-safe.js"></script>
EOF

# =========================
# Body Hook
# =========================
cat > layouts/partials/extend_body.html <<'EOF'
<div class="dashboard-topbar">
  <div class="dashboard-left">
    <span id="dash-toggle" class="dashboard-toggle">☰</span>
    <span class="dashboard-brand">DevOps Dashboard</span>
  </div>
  <button id="dash-theme-btn" class="dashboard-theme-btn">🌓</button>
</div>

<div id="dash-sidebar" class="dashboard-sidebar">
  <a href="/">🏠 Home</a>
  <a href="/posts/">📝 Notes</a>
  <a href="/tags/">🏷 Tags</a>
</div>
EOF

echo "✅ Safe dashboard UI applied"
echo "Now run:"
echo "hugo server --disableFastRender"
echo "Then hard refresh: Ctrl + Shift + R"

