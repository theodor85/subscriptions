module Subscriptions
  module Operations
    class MessageParser
      include ::Dry::Monads[:result]
      include Import[:echo]

      def call(message)
        Success(echo)
      end
    end
  end
end
