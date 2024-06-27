# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chartkick", to: "chartkick.js"
pin "Chart.bundle", to: "Chart.bundle.js"
pin "popper", to: 'https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js', preload: true
pin "bootstrap", to: 'https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js', preload: true
pin_all_from 'app/javascript/vendor', under: 'vendor'
pin "jquery", to: "https://code.jquery.com/jquery-3.7.1.min.js", preload: true
