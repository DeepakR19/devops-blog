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
