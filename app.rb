# frozen_string_literal: true

require 'sinatra'
require_relative './container'

require 'dotenv'
Dotenv.load

module Subscriptions
  class App < Sinatra::Application
    include Import[:router, :telegram_sender]

    post "/#{ENV['WEBHOOK_ENDPOINT']}" do
      answer = router.(params.merge(update: JSON.parse(request.body.read)))
      telegram_sender.(answer[:chat_id], answer[:message]) unless answer.nil?

      'ok'
    end
  end
end
