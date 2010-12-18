# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
require "bundler"
Bundler.setup

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rspec/rails"
require 'database_cleaner'
require 'lib/imp'
require "lib/imp/in_memory_database"

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers

  config.mock_with :rspec
  config.formatter = 'documentation'

  config.use_transactional_fixtures = false

  config.before(:all) do
    enabled_memory_database?
    DatabaseCleaner.app_root = File.expand_path("../dummy",  __FILE__)
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end


####################################################
## Fixes 'loos session' bug.
## Happens because capybara (and selenium, eventmachine,...)
## starts a webserver in a background thread which dont
## has access to the running transactions.
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
## Forces all threads to share the same connection.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
####################################################
