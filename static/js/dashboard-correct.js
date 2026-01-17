(function () {
  function applyThemeFromStorage() {
    const pref = localStorage.getItem("pref-theme");
    if (pref === "dark") {
      document.body.classList.add("dark");
    } else if (pref === "light") {
      document.body.classList.remove("dark");
    }
  }

  document.addEventListener("DOMContentLoaded", function () {
    applyThemeFromStorage();

    const toggle = document.getElementById("dash-toggle");
    const sidebar = document.getElementById("dash-sidebar");
    const main = document.getElementById("dash-main");
    const themeBtn = document.getElementById("theme-toggle-btn");

    if (toggle && sidebar && main) {
      toggle.addEventListener("click", function () {
        sidebar.classList.toggle("collapsed");
        main.classList.toggle("full");
      });
    }

    if (themeBtn) {
      themeBtn.addEventListener("click", function () {
        const isDark = document.body.classList.contains("dark");
        if (isDark) {
          document.body.classList.remove("dark");
          localStorage.setItem("pref-theme", "light");
        } else {
          document.body.classList.add("dark");
          localStorage.setItem("pref-theme", "dark");
        }
      });
    }
  });
})();
