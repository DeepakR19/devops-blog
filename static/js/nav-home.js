let lastScroll = 0;
const nav = document.getElementById("navHome");

window.addEventListener("scroll", () => {
  if (!nav) return;

  const current = window.scrollY;

  if (current > lastScroll && current > 80) {
    nav.classList.add("hidden");
  } else {
    nav.classList.remove("hidden");
  }

  lastScroll = current;
});
