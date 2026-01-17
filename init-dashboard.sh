#!/bin/bash
set -e

echo "Installing Phase 4E: Command blocks with copy button"

# ---------------------------
# Update CSS for command blocks
# ---------------------------
cat >> static/css/main.css << 'EOF'

/* Phase 4E: Command blocks */
pre {
  position: relative;
  padding: 16px;
  border-radius: 12px;
  background: rgba(0,0,0,0.05);
  overflow-x: auto;
  border: 1px solid var(--border);
}

body.dark pre {
  background: rgba(255,255,255,0.05);
}

.copy-btn {
  position: absolute;
  top: 8px;
  right: 8px;
  padding: 4px 8px;
  font-size: 0.75rem;
  border-radius: 6px;
  border: 1px solid var(--border);
  background: transparent;
  color: var(--text);
  cursor: pointer;
}

.copy-btn:hover {
  opacity: 0.8;
}
EOF

# ---------------------------
# Update JS: auto-add copy buttons
# ---------------------------
cat > static/js/main.js << 'EOF'
document.addEventListener("DOMContentLoaded", function () {
  const themeToggle = document.getElementById("themeToggle");
  const searchInput = document.getElementById("searchInput");
  const navLinks = document.querySelectorAll(".nav-link");

  // Theme persistence
  const savedTheme = localStorage.getItem("theme");
  if (savedTheme === "dark") {
    document.body.classList.add("dark");
  }

  themeToggle?.addEventListener("click", () => {
    document.body.classList.toggle("dark");
    const mode = document.body.classList.contains("dark") ? "dark" : "light";
    localStorage.setItem("theme", mode);
  });

  // Active link highlight
  const currentPath = window.location.pathname;
  navLinks.forEach(link => {
    const href = link.getAttribute("href");
    if (currentPath.startsWith(href)) {
      link.classList.add("active");
    }
  });

  // Search filter
  searchInput?.addEventListener("input", function () {
    const query = this.value.toLowerCase();
    navLinks.forEach(link => {
      const text = link.innerText.toLowerCase();
      link.style.display = text.includes(query) ? "inline-flex" : "none";
    });
  });

  // 📋 Copy buttons for code blocks
  document.querySelectorAll("pre").forEach(pre => {
    const btn = document.createElement("button");
    btn.innerText = "Copy";
    btn.className = "copy-btn";

    btn.addEventListener("click", () => {
      const code = pre.innerText;
      navigator.clipboard.writeText(code).then(() => {
        btn.innerText = "Copied!";
        setTimeout(() => btn.innerText = "Copy", 1200);
      });
    });

    pre.appendChild(btn);
  });
});
EOF

echo "Phase 4E installed."
echo "Restart Hugo: hugo server --disableFastRender"
