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
