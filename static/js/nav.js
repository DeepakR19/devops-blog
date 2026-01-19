let lastScroll = 0;
const nav = document.getElementById("homeTopNav");

if (nav) {
  window.addEventListener("scroll", () => {
    const currentScroll = window.pageYOffset;

    if (currentScroll > lastScroll && currentScroll > 80) {
      nav.classList.add("hidden");
    } else {
      nav.classList.remove("hidden");
    }

    lastScroll = currentScroll;
  });
}
