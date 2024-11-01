# frozen_string_literal: true

require 'dry/auto_inject'
require 'dry/container'

class Container
  extend Dry::Container::Mixin

  register(:config) do
    require_relative './app/config'

    ::Subscriptions::Config.new(tg_token: ENV['TG_TOKEN'],
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

    Http::Client.new
  end

  register('states.qwestion') do
    require_relative './app/states/qwestion'

    States::Qwestion.new
  end

  register('operations.qwestion.turn_off') do
    require_relative './app/operations/qwestion/turn_off'

    Operations::Qwestion::TurnOff.new
  end

  register('operations.qwestion.turn_on') do
    require_relative './app/operations/qwestion/turn_on'

    Operations::Qwestion::TurnOn.new
  end

  register('operations.qwestion.return_to_main') do
    require_relative './app/operations/qwestion/return_to_main'

    Operations::Qwestion::ReturnToMain.new
  end

  register('operations.qwestion.error') do
    require_relative './app/operations/qwestion/error'

    Operations::Qwestion::Error.new
  end

  register('states.initial') do
    require_relative './app/states/initial'

    States::Initial.new
  end

  register('operations.initial.echo') do
    require_relative './app/operations/initial/echo'

    Operations::Initial::Echo.new
  end

  register('operations.initial.do_nothing') do
    require_relative './app/operations/initial/do_nothing'

    Operations::Initial::DoNothing.new
  end

  register('state_machine.get_current_state') do
    require_relative './app/state_machine/get_current_state'

    StateMachine::GetCurrentState.new
  end

  register('state_machine.get_operation') do
    require_relative './app/state_machine/get_operation'

    StateMachine::GetOperation.new
  end

  register('state_machine.save_state') do
    require_relative './app/state_machine/save_state'

    StateMachine::SaveState.new
  end

  register(:telegram_sender) do
    require_relative './app/telegram/sender'

    Telegram::Sender.new
  end

  register(:router) do
    require_relative './app/router'
    Router.new
  end
end

Import = Dry::AutoInject(Container)
