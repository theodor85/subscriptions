ENV['RACK_ENV'] = 'test'

require './app'
require 'rspec'
require 'rack/test'
require 'json'

require 'dotenv'
Dotenv.load

Dir[File.join('spec', 'support', '**', '*.rb')].each { |f| load f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include_context :sending_messages, type: :sending_messages

  def app
    Subscriptions::App
  end
end