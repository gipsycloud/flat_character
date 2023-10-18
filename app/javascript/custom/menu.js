// // JavaScript to toggle the mobile menu
const mobileMenu = document.getElementById("mobile-menu");
const menuToggle = document.getElementById("menu-toggle");

menuToggle.addEventListener("click", () => {
    mobileMenu.classList.toggle("hidden");
});