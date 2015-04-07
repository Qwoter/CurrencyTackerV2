ruby '2.1.5'

source 'http://rubygems.org'

gem 'rails'
# gem 'sqlite3'

group :development do
  gem 'capybara'
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :assets do
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.2.0'
gem 'jbuilder'
gem 'heroku-rglpk', :git => 'https://github.com/bearded-nemesis/heroku-rglpk.git', :require => 'rglpk'
gem 'pg'
gem 'database_cleaner', git: 'git@github.com:DatabaseCleaner/database_cleaner.git'
