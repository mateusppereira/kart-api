source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'codecov', :require => false, :group => :test
gem 'pg', '>= 0.18', '< 2.0'
gem 'pry-rails'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]