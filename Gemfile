source "https://rubygems.org"

# Declare your gem's dependencies in subscriptions.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'

gem 'devise'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails'

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers'
  gem 'jazz_hands'
  gem 'better_errors'
end

group :test do
  gem "vcr" #Records HTTP requests and replays them for tests
  gem "launchy"
  gem "temping" #creates on the fly dummy active record classes
  gem "webmock" #mocks out HTTP requests
  gem 'pry' #debugging into a console
  gem 'capybara', '~> 2.1'
  gem 'capybara-webkit'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'selenium-webdriver', '~> 2.35'
  gem 'database_cleaner', '< 1.1.0'
end

