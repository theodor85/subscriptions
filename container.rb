require 'dry/auto_inject'
require 'dry/container'

module Subscriptions
  class Container
    extend Dry::Container::Mixin

    register(:config) do
      require_relative './app/config'

      Subscriptions::Config.new(tg_token: ENV['TG_TOKEN'],
                                tg_url:  ENV['TG_URL'],
                                tg_bot_id: ENV['TG_BOT_ID'],
                                webhook_url: "#{ENV['WEBHOOK_URL']}#{ENV['WEBHOOK_ENDPOINT']}",
                                webhook_secret_token: ENV['WEBHOOK_SECRET_TOKEN'])
    end

    register(:http_connection) do
      require 'faraday'

      Faraday.new
    end

    register(:http_client) do
      require_relative './app/http/client'

      Subscriptions::Http::Client.new
    end

    register(:telegram) do
      require_relative './app/gateways/telegram'

      Subscriptions::Gateways::Telegram.new
    end

    register(:router) do
      require_relative './app/router'
      Subscriptions::Router.new
    end

    register(:ping) do
      require_relative './app/controllers/ping'
      Subscriptions::Controllers::Ping.new
    end

    register(:update_handler) do
      require_relative './app/controllers/update_handler'
      Subscriptions::Controllers::UpdateHandler.new
    end
  end

  Import = Dry::AutoInject(Container)
end
