require 'rack/test'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

require_relative '../app'
require_relative '../listing'
require_relative 'support/response_helpers'

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.pattern = '**/*_spec.rb'
  config.include Rack::Test::Methods
  config.include ResponseHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :each do |example|
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  def app
    App
  end
end
