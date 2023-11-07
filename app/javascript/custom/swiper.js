// app/javascript/packs/swiper.js

import swiper from 'https://cdn.jsdelivr.net/npm/swiper@11.0.3/+esm'
$(document).on("turbo:load", function() {
// Initialize Swiper
const mySwiper = new Swiper('.swiper', {
  slidesPerView: 5,
  spaceBetween: 15,
  loop: true,
  centerSlide: 'true',
  fade: 'true',
  grabCursor: 'true',
  autoHeight: 'true',
  observer: true,  
  observeParents: true,
  keyboard: true,
  // mousewheel: true,
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