require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)



module Angle
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += %W(#{config.root}/lib)

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    # setup bower components folder for lookup
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components', 'lib')

    config.assets.paths << Rails.root.join('app', 'assets', 'videos')

    # fonts
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    # images
    config.assets.precompile << /\.(?:png|jpg)$/
    # precompile vendor assets
    config.assets.precompile += %w( base.js )
    config.assets.precompile += %w( base.css )
    # precompile themes
    config.assets.precompile += [
                                    'wraith/themes/theme-a.css',
    #                              'angle/themes/theme-b.css',
    #                              'angle/themes/theme-c.css',
    #                              'angle/themes/theme-d.css',
                                 # 'wraith/themes/theme-e.css'
                                 # 'angle/themes/theme-f.css',
                                 # 'angle/themes/theme-g.css',
                                 # 'angle/themes/theme-h.css'
                                ]
    # Controller assets
    config.assets.precompile += [
                                 # Scripts
                                 'charts.js',
                                 'dashboard.js',
                                 'documentation.js',
                                 'elements.js',
                                 'extras.js',
                                 'forms.js',
                                 'maps.js',
                                 'multilevel.js',
                                 'pages.js',
                                 'tables.js',
                                 'widgets.js',
                                 'blog.js',
                                 'ecommerce.js',
                                 'forum.js',
                                 #added
                                 'companies.js',
                                 'skynets.js',
                                 'home.js',
                                 'vendoritems.js',
                                 'vendors.js',
                                 # Stylesheets
                                 'charts.css',
                                 'dashboard.css',
                                 'documentation.css',
                                 'elements.css',
                                 'extras.css',
                                 'forms.css',
                                 'maps.css',
                                 'multilevel.css',
                                 'pages.css',
                                 'tables.css',
                                 'widgets.css',
                                 'blog.css',
                                 'ecommerce.css',
                                 'forum.css',
                                 'home.css',
                                 'subscriptions.css',
                                 #added
                                 'skynets.css',
                                 'vendoritems.css',
                                 'companies.css',
                                 'vendors.css',
                                 'users/registrations.css',
                                 'users/sessions.css',
                                 'users/passwords.css'
                                ]


  end
end


