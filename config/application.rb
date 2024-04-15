require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module SharedHouseholdAccountBook
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.i18n.default_locale = :ja
    config.i18n.available_locales = [:ja, :en]
    config.exceptions_app = self.routes
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
