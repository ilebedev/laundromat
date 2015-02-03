source 'https://rubygems.org'

# Rails!
gem 'rails', '4.1.6'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Bootstrap framework for the UI
gem 'bootstrap-sass', '~> 3.3.1'
gem 'sprockets-rails', '~> 2.2.2'

# Font awesome
gem 'font-awesome-sass'

# ZeroClipboard for copy buttons
gem 'zeroclipboard-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Authentication
gem 'devise', '~> 3.3.0'
gem 'omniauth', '~> 1.2.2'
gem 'omniauth-facebook', '~> 2.0.0'
gem 'omniauth-google-oauth2', '~> 0.2.5'
gem 'omniauth-twitter', '~> 1.1.0'
gem 'omniauth-github', '~> 1.1.2'

# Hide passwords from terminal when using capistrano
gem 'highline', '~> 1.6.21'

# Non-production gems
group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :deployment do
  # Use Capistrano for deployment
  gem 'capistrano', '~> 3.2.1', require: false
  gem 'capistrano-bundler', '~> 1.1.3', require: false
  gem 'capistrano-rails', '~> 1.1.2', require: false
  gem 'rvm1-capistrano3', '~> 1.3.2', require: false
  gem 'capistrano-secrets-yml', '~> 1.0.0', require: false
  gem 'capistrano-thin', git: 'git@github.com:freego/capistrano-thin.git', require: false
  gem 'capistrano3-nginx', '~> 2.0.4', git: 'git@github.com:ilebedev/capistrano3-nginx.git', require: false
end

group :development, :test do
  # Use the byebug debugger
  gem 'byebug'

  # Platform-specific gems in case we touch windows
  platforms :x64_mingw, :mingw, :mswin do
    # Timezones fix for windows
    gem 'tzinfo-data'
  end
end

group :production do
  # Use thin webserver
  gem 'thin', '~> 1.6.3'
end
