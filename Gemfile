source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4'

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.0'
end
