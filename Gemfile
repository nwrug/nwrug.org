source 'https://rubygems.org'

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~>8.0'
gem 'bootsnap'
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# For rendering markdown as HTML
gem 'github-markup'
gem 'redcarpet'
# Use ActiveModel has_secure_password
gem 'bcrypt'

gem 'puma'

# Temporarily lock concurrent-ruby version until we're on Rails 7.1
gem 'concurrent-ruby', '1.3.4'

group :production do
  # Used to load secrets via environment variables on production
  gem 'dotenv-rails'
end

group :development do
  gem 'ed25519', '>= 1.2', '< 2.0', require: false
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0', require: false
  # Use an evented file watcher to asynchronously detect changes
  gem 'listen'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :development, :test do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capybara'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
end
