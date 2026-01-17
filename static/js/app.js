document.addEventListener("DOMContentLoaded", () => {
  const themeBtn = document.getElementById("toggle-theme");
  const sidebarBtn = document.getElementById("toggle-sidebar");
  const sidebar = document.getElementById("sidebar");

  const pref = localStorage.getItem("theme");
  if (pref === "dark") document.body.classList.add("dark");

  if (themeBtn) {
    themeBtn.onclick = () => {
      document.body.classList.toggle("dark");
      localStorage.setItem("theme",
        document.body.classList.contains("dark") ? "dark" : "light"
      );
    };
  }

  if (sidebarBtn) {
    sidebarBtn.onclick = () => {
      sidebar.classList.toggle("collapsed");
    };
  }
});
