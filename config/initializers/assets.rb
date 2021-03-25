# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

#app/assets/
Rails.application.config.assets.precompile += %w(site.coffee site.scss
                                                pilot_devise.js pilot_devise.scss
                                                operator_devise.js operator_devise.scss
                                                pilots_backoffice.coffee pilots_backoffice.scss
                                                pratico_escada.jpg tanker_santos.jpg
                                                operators_backoffice.coffee operators_backoffice.scss
                                                atalaia.jpg operacao_atalaia.jpg
                                                mestrado_1.jpg mestrado_2.jpg
                                                etown.jpeg mbm.jpg)