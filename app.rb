# frozen_string_literal: true

require 'sinatra'
require_relative './container'

require 'dotenv'
Dotenv.load

module Subscriptions
  class App < Sinatra::Application
    include Import[:router, :telegram_sender]

    post "/#{ENV['WEBHOOK_ENDPOINT']}" do
      rqst_body = request.body.read
      puts "*********** request.body=#{rqst_body}"
      puts "*********** params=#{params}"

      result = router.(params.merge(update: JSON.parse(rqst_body)))
      telegram_sender.(result.value!) if result.success?
      telegram_sender.(result.failure) if result.failure?

      'ok'
    rescue JSON::ParserError
      telegram_sender.(639_085_762, 'Invalid JSON')
    end

    get '/healthcheck' do
      'ok'
    end
  end
end
