// app/javascript/packs/swiper.js

import swiper from 'https://cdn.jsdelivr.net/npm/swiper@11.0.3/+esm'
$(document).on("turbo:load", function() {
// Initialize Swiper
const mySwiper = new Swiper('.swiper-container', {
  // Your Swiper configuration options here
  loop: true,
  slidesPerView: 3,
  spaceBetween: 10,
  // Add more options as needed
  autoplay: {
    delay: 5000,
  },
  navigation: {
    nextEl: '.button-next',
    prevEl: '.button-prev',
  },
  // pagination: {
  //   el: '.swiper-pagination',
  //   clickable: true,
  // },
});
});