source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem "ransack", "~> 2.4"
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'redis'
gem 'geocoder', '~> 1.3', '>= 1.3.7'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise'
gem 'mini_magick'
gem "aws-sdk-s3", require: false
gem 'hamlit-rails'
gem "font-awesome-rails"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'
  gem 'database_rewinder'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'webmock'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
