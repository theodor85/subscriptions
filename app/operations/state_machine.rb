module Subscriptions
  module Operations
    class StateMachine
      include ::Dry::Monads[:result]
      include Import[:config, :redis, :echo]

      def get_current_state(user_id)
        state = redis.get("#{user_id}_state")
        return Success([:initial, {}]) if state.nil? || state == 'initial'

        state_data = redis.get("#{user_id}_state_data")
        puts "********** state_data=#{state_data}"
        Success([state.to_sym, JSON.parse(state_data)])
      end

      def get_operation(state, update)
        nil unless update.message.text == '/echo' && state == :initial

        Success(echo)
      end

      def save_state(user_id:, state:, data:)
        redis.set("#{user_id}_state", state)
        redis.set("#{user_id}_state_data", data.to_json)

        Success()
      end
    end
  end
end
