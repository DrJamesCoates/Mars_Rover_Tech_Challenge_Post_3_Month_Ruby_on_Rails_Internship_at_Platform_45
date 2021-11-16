source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'
gem 'rails',                      '~> 6.1.4', '>= 6.1.4.1'
gem 'sqlite3',                    '~> 1.4'
gem 'puma',                       '~> 5.0'
gem 'bootstrap-sass',             '3.4.1'
gem 'sass-rails',                 '>= 6'
gem 'webpacker',                  '~> 5.0'
gem 'turbolinks',                 '~> 5'
gem 'jbuilder',                   '~> 2.7'
gem 'bootsnap',                   '>= 1.4.4', require: false
gem 'will_paginate',              '3.3.0'
gem 'bootstrap-will_paginate',    '1.0.0'

group :test do
  gem 'factory_bot_rails',        '~> 4.0'
  gem 'shoulda-matchers',         '~> 3.1'
  gem 'database_cleaner'
end

group :development, :test do
  gem 'rspec-rails',              '~> 4.0'
  gem 'pry'
end

group :development do
  gem 'web-console',              '>= 4.1.0'
  gem 'rack-mini-profiler',       '~> 2.0'
  gem 'listen',                   '~> 3.3'
  gem 'spring'
end

