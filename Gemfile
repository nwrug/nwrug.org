source 'https://rubygems.org'

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.4.5'
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

group :production do
  # Used to load secrets via environment variables on production
  gem 'dotenv-rails'
end

group :development do
  gem 'capistrano', '~> 3.14'
  gem 'capistrano-bundler', '~> 1.6'
  gem 'capistrano-rails', '~> 1.5'
  gem 'capistrano-passenger', '~> 0.2'
  # Use an evented file watcher to asynchronously detect changes
  gem 'listen'
  gem 'puma'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'capybara'
  gem 'brakeman', require: false
  gem 'bundler-audit', require: false
end
