require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSpace0
  class Application < Rails::Application
    # 『g』起動時、使用しないファイルの生成を取り止める記述。
    config.generators do |g|
      g.javascripts false
      g.helper false
      g.test_framework false
    end

    # デフォルトのlocaleを日本語（:ja）に設定。
    config.i18n.default_locale = :ja

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
