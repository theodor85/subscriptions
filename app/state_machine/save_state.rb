# frozen_string_literal: true

module Subscriptions
  module StateMachine
    class SaveState
      include ::Dry::Monads[:result]
      include Import[:redis]

      def call(user_id:, state:, data:)
        redis.set("#{user_id}_state", state)
        redis.set("#{user_id}_state_data", data.to_json)

        Success()
      end
    end
  end
end
