$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "subscriptions/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "subscriptions"
  s.version     = Subscriptions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses     = ["MIT"]
  s.authors     = ["Javid Jamae", "Hector Villarreal"]
  s.homepage    = "http://www.camperoo.com"
  s.summary     = "A multi-tenanted subscription-billing service for Ruby on Rails."
  s.description = "Subscriptions is a multi-tenanted subscription-billing service for Ruby on Rails. Think Chargify or Stripe, but as a mounted engine in your own application. It can hook into any payment provider than ActiveMerchant supports."

  s.rubyforge_project = "subscriptions"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/* spec_no_rails/*`.split("\n")

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
