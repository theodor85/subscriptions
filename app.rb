# frozen_string_literal: true

require 'sinatra'
require_relative './container'

require 'dotenv'
Dotenv.load

module Subscriptions
  class App < Sinatra::Application
    include Import[:router, :config]

    get '/ping' do
      router.(params)
    end

    post "/#{ENV['WEBHOOK_ENDPOINT']}" do
      router.(params.merge(update: JSON.parse(request.body.read)))
    end
  end
end
