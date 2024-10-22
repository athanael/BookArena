# config/importmap.rb

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# FullCalendar
pin "fullcalendar", to: "https://cdn.jsdelivr.net/npm/fullcalendar@6.1.4/index.global.min.js"
