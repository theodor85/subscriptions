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

    register('states.qwestion') do
      require_relative './app/states/qwestion'

      Subscriptions::States::Qwestion.new
    end

    register('operations.turn_off') do
      require_relative './app/operations/turn_off'

      Subscriptions::Operations::TurnOff.new
    end

    register('operations.turn_on') do
      require_relative './app/operations/turn_on'

      Subscriptions::Operations::TurnOn.new
    end

    register('operations.return_to_main') do
      require_relative './app/operations/return_to_main'

      Subscriptions::Operations::ReturnToMain.new
    end

    register('operations.error') do
      require_relative './app/operations/error'

      Subscriptions::Operations::Error.new
    end

    register('states.initial') do
      require_relative './app/states/initial'

      Subscriptions::States::Initial.new
    end

    register('operations.echo') do
      require_relative './app/operations/echo'

      Subscriptions::Operations::Echo.new
    end

    register('operations.do_nothing') do
      require_relative './app/operations/do_nothing'

      Subscriptions::Operations::DoNothing.new
    end

    register('state_machine.get_current_state') do
      require_relative './app/state_machine/get_current_state'

      Subscriptions::StateMachine::GetCurrentState.new
    end

    register('state_machine.get_operation') do
      require_relative './app/state_machine/get_operation'

      Subscriptions::StateMachine::GetOperation.new
    end

    register('state_machine.save_state') do
      require_relative './app/state_machine/save_state'

      Subscriptions::StateMachine::SaveState.new
    end

    register(:telegram_sender) do
      require_relative './app/telegram/sender'

      Subscriptions::Telegram::Sender.new
    end

    register(:router) do
      require_relative './app/router'
      Subscriptions::Router.new
    end
  end

  Import = Dry::AutoInject(Container)
end
