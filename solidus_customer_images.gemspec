# frozen_string_literal: true

$:.push File.expand_path('../lib', __FILE__)
require 'solidus_customer_images/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_customer_images'
  s.version     = SolidusCustomerImages::VERSION
  s.summary     = 'Customer images upload for Solidus'
  s.description = 'Solidus extension that allows customers to upload their images, with admin moderation'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Andrea Longhi'
  s.email     = 'andrealonghi@nebulab.it'
  s.homepage  = 'https://github.com/nebulab/solidus_customer_images'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'solidus_core', '~> 2.6'
  s.add_dependency 'deface', '~> 1.3'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop', '>= 0.49.0'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'rails-controller-testing'
end
