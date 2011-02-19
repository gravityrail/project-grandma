source 'http://rubygems.org'

gem 'rails', '3.0.4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'omniauth'
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'
gem 'oauth2', :git => 'git://github.com/intridea/oauth2.git'
gem 'warden-facebook', :git=>'git://github.com/maca/warden-facebook.git'
gem "oa-oauth", :require => "omniauth/oauth"
gem "will_paginate"
gem 'simple-navigation'
gem 'vestal_versions'
gem 'formtastic'
#gem 'table_builder'



# for video uploads
gem 'paperclip'
gem 'delayed_job'
#gem 'delayed_paperclip'
gem 's3_swf_upload', :git => 'git://github.com/nathancolgate/s3-swf-upload-plugin'

# for zencoder
gem 'zencoder'
gem 'zencoder-fetcher'
gem 'httparty'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

group :development, :test do
  gem 'sqlite3'
  gem "unicorn"
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "heroku"
#  gem "ruby-debug"

  gem "rspec-rails"
  gem "shoulda-matchers"
  gem 'cucumber-rails'
  gem 'capybara', :git => 'git://github.com/aslakhellesoy/capybara.git'
  gem 'database_cleaner'

  gem 'factory_girl_rails'

  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page

  gem "autotest"
  gem "autotest-growl"
  gem "autotest-rails-pure"
  gem "autotest-fsevent"

  gem "rcov"
end
