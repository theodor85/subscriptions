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

      result = router.(params.merge(update: JSON.parse(rqst_body)))
      telegram_sender.(result.value![:chat_id], result.value![:message]) if result.success?

      'ok'
    rescue JSON::ParserError
      telegram_sender.(639_085_762, 'Invalid JSON')
    end

    get '/healthcheck' do
      'ok'
    end
  end
end
