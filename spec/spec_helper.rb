# frozen_string_literal: true

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
  config.include Import[:router]
  config.include_context 'when sending messages', type: :router

  def app
    App
  end
end
