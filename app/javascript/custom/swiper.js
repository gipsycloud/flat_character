// app/javascript/packs/swiper.js
// https://swiperjs.com/get-started

// import Swiper from 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.mjs';
import swiper from 'https://cdn.jsdelivr.net/npm/swiper@11.0.3/+esm'
import Swiper from 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.mjs'

document.addEventListener('turbo:load', () => {
    // Initialize Swiper
    new Swiper('.swiper', {
      slidesPerView: 5,
      spaceBetween: 15,
      loop: true,
      centeredSlides: true,
      effect: 'fade',
      grabCursor: true,
      autoHeight: true,
      observer: true,
      observeParents: true,
      keyboard: true,
      autoplay: false,
      autoplay: {
        delay: 5000,
      },
      navigation: {
        nextEl: '.button-next',
        prevEl: '.button-prev',
      },
    });
  });
