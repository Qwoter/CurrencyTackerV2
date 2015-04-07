ruby '2.1.2'

source 'http://rubygems.org'

gem 'rails', '4.1.8'
# gem 'sqlite3'

group :development do
  gem 'capybara'
end

group :production do
  gem 'pg'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test, :development do
  gem 'mysql2'
  gem 'database_cleaner'
end

group :assets do
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '~> 2.2.0'
gem 'jbuilder'
gem 'heroku-rglpk', :git => 'https://github.com/bearded-nemesis/heroku-rglpk.git', :require => 'rglpk'
