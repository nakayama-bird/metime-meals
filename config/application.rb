require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w(assets tasks))

    # 不要なファイルを作成しない
    config.generators do |g|
      g.helper false             # helper ファイルを作成しない
      g.test_framework false     # test ファイルを作成しない
      g.skip_routes true         # ルーティングの記述を作成しない
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    # タイムゾーンの設定
    config.time_zone = "Tokyo"

    # デフォルト言語の設定
    config.i18n.default_locale = :ja

    # libファイルの読み込み
    config.autoload_lib(ignore: %w(assets tasks))

    # config.eager_load_paths << Rails.root.join("extras")
  end
end
