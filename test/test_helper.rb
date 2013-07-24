# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'test/unit'
require 'rails'

class FakeApplication < Rails::Application; end

Rails.application = FakeApplication
Rails.configuration.action_controller = ActiveSupport::OrderedOptions.new

require 'common_validators'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
