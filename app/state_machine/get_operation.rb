# frozen_string_literal: true

module Subscriptions
  module StateMachine
    class GetOperation
      include Import[
        'states.initial',
        'states.qwestion'
      ]

      def call(state:, update:)
        send(state).call(update)
      end
    end
  end
end
