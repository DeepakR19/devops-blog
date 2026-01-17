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
