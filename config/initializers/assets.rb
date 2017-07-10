# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile = ['after_registration.js', 'login.js', 'login.css','login_footer.js', 'dashboard_footer.js','dashboard.js','dashboard.css','*.png' ]
Rails.application.config.assets.precompile += %w( ckeditor/application.css )
Rails.application.config.assets.precompile += %w( ckeditor/application.js )
Rails.application.config.assets.precompile += %w( events.js )
Rails.application.config.assets.precompile += %w( cep.js )
Rails.application.config.assets.precompile += %w( crew/trocar_vaga.js )
