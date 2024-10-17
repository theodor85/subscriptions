require 'dry/auto_inject'
require 'dry/container'

module Subscriptions
  class Container
    extend Dry::Container::Mixin

    register(:config) do
      require_relative './app/config'

      Subscriptions::Config.new(tg_token: ENV['TG_TOKEN'],
                                tg_url: ENV['TG_URL'],
                                tg_bot_id: ENV['TG_BOT_ID'],
                                webhook_url: "#{ENV['WEBHOOK_URL']}#{ENV['WEBHOOK_ENDPOINT']}",
                                webhook_secret_token: ENV['WEBHOOK_SECRET_TOKEN'])
    end

    register(:redis) do
      require 'redis'

      Redis.new(url: ENV['REDIS_URL'])
    end

    register(:http_connection) do
      require 'faraday'

      Faraday.new
    end

    register(:http_client) do
      require_relative './app/http/client'

      Subscriptions::Http::Client.new
    end

    register(:state_machine) do
      require_relative './app/operations/state_machine'

      Subscriptions::Operations::StateMachine.new
    end

    register(:telegram_sender) do
      require_relative './app/telegram/sender'

      Subscriptions::Telegram::Sender.new
    end

    register(:echo) do
      require_relative './app/operations/echo'

      Subscriptions::Operations::Echo.new
    end

    register(:message_parser) do
      require_relative './app/operations/message_parser'

      Subscriptions::Operations::MessageParser.new
    end

    register(:router) do
      require_relative './app/router'
      Subscriptions::Router.new
    end
  end

  Import = Dry::AutoInject(Container)
end
