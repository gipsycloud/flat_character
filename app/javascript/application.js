// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery
import "jquery_ujs"

// import "./jqueryjs"
import 'flowbite'
import 'flowbite-datepicker'

import "custom/swiper"
import "custom/password_toggle"
import "room_checkout"
import "mapkick/bundle"

import "controllers"
