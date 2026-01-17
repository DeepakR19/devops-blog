#!/usr/bin/env bash
set -e

echo "Applying FINAL FIXED DevOps Dashboard UI..."

mkdir -p static/css static/js layouts/partials

# =========================
# CSS
# =========================
cat > static/css/dashboard-final-fixed.css <<'EOF'
/* Hide PaperMod's theme toggle & header conflicts */
.theme-toggle, .top-link, header, .nav {
  display: none !important;
}

/* Dashboard variables */
:root {
  --dash-bg: var(--theme);
  --dash-card: var(--entry);
  --dash-border: var(--border);
  --dash-text: var(--primary);
  --dash-muted: var(--secondary);
  --dash-accent: var(--link-color);
}

/* Top bar */
.dashboard-topbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  height: 56px;
  background: var(--dash-bg);
  border-bottom: 1px solid var(--dash-border);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 1rem;
  z-index: 10000;
}

.dashboard-left {
  display: flex;
  align-items: center;
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

.theme-btn {
  cursor: pointer;
  border: 1px solid var(--dash-border);
  padding: 4px 10px;
  border-radius: 8px;
  background: var(--dash-card);
  color: var(--dash-text);
}

/* Sidebar */
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
  margin-bottom: 4px;
}

.dashboard-sidebar a:hover {
  background: var(--dash-card);
}

/* Main content fix */
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

/* Remove PaperMod width limits */
.main {
  max-width: 100% !important;
  padding-left: 0 !important;
  padding-right: 0 !important;
}
EOF

# =========================
# JS
# =========================
cat > static/js/dashboard-final-fixed.js <<'EOF'
(function () {
  function applyTheme() {
    const pref = localStorage.getItem("pref-theme");
    if (pref === "dark") {
      document.body.classList.add("dark");
    } else {
      document.body.classList.remove("dark");
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    applyTheme();

    const toggle = document.getElementById("dash-toggle");
    const sidebar = document.getElementById("dash-sidebar");
    const main = document.getElementById("dash-main");
    const themeBtn = document.getElementById("theme-btn");

    if (toggle && sidebar && main) {
      toggle.onclick = () => {
        sidebar.classList.toggle("collapsed");
        main.classList.toggle("full");
      };
    }

    if (themeBtn) {
      themeBtn.onclick = () => {
        const isDark = document.body.classList.contains("dark");
        if (isDark) {
          document.body.classList.remove("dark");
          localStorage.setItem("pref-theme", "light");
        } else {
          document.body.classList.add("dark");
          localStorage.setItem("pref-theme", "dark");
        }
      };
    }
  });
})();
EOF

# =========================
# Head Hook
# =========================
cat > layouts/partials/extend_head.html <<'EOF'
<link rel="stylesheet" href="/css/dashboard-final-fixed.css">
<script defer src="/js/dashboard-final-fixed.js"></script>
EOF

# =========================
# Footer Hook (Safe Injection)
# =========================
cat > layouts/partials/extend_footer.html <<'EOF'
<div class="dashboard-topbar">
  <div class="dashboard-left">
    <span id="dash-toggle" class="dashboard-toggle">☰</span>
    <div class="dashboard-brand">DevOps Dashboard</div>
  </div>
  <button id="theme-btn" class="theme-btn">🌓</button>
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

echo "✅ FINAL FIX APPLIED"
echo "Run:"
echo "hugo server --disableFastRender"
echo "Then HARD refresh: Ctrl + Shift + R"

