# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "mapkick/bundle", to: "mapkick.bundle.js"
pin "mapbox-gl", to: "https://ga.jspm.io/npm:mapbox-gl@2.15.0/dist/mapbox-gl.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.1/dist/jquery.js", preload: true # Using the CDN version
pin "jquery_ujs", to: "https://ga.jspm.io/npm:jquery-ujs@1.2.3/src/rails.js", preload: true # Using the CDN version
pin "flowbite", to: "https://cdn.jsdelivr.net/npm/flowbite@2.5.2/dist/flowbite.turbo.min.js"
pin "flowbite-datepicker", to: "https://cdn.jsdelivr.net/npm/flowbite@2.3.0/dist/datepicker.turbo.min.js"
pin "custom/swiper", to: "custom/swiper.js"
pin "custom/password_toggle", to: "custom/password_toggle.js"
pin "room_checkout", to: "room_checkout.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.0.0/flowbite.turbo.min.js"
# pin "flowbite-datepicker", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.0.0/datepicker.turbo.min.js"
# pin "jquery", to: "jquery.min.js", preload: true
# pin "jquery_ujs", to: "jquery_ujs.js", preload: true
# pin "jquery" # @4.0.0 # This pin was commented out, but its previous content was conflicting with the next lines.