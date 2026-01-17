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
