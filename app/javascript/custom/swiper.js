// app/javascript/packs/swiper.js
// https://swiperjs.com/get-started

import Swiper from 'https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.mjs'

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.swiper').forEach((element) => {
    if (element.swiper) return

    new Swiper(element, {
      slidesPerView: 1.2,
      spaceBetween: 16,
      loop: true,
      grabCursor: true,
      observer: true,
      observeParents: true,
      keyboard: true,
      autoplay: {
        delay: 5000,
        disableOnInteraction: false,
      },
      breakpoints: {
        640: {
          slidesPerView: 2.2,
        },
        1024: {
          slidesPerView: 4,
        },
      },
    })
  });
})
