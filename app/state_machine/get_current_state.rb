# frozen_string_literal: true

module Subscriptions
  module StateMachine
    class GetCurrentState
      include ::Dry::Monads[:result]
      include Import[:redis]

      def call(user_id:)
        state = redis.get("#{user_id}_state")
        return Success([:initial, {}]) if state.nil? || state == 'initial'

        state_data = redis.get("#{user_id}_state_data")
        Success([state.to_sym, JSON.parse(state_data)])
      end
    end
  end
end
