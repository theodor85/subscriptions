module Subscriptions
  module Operations
    class MessageParser
      include ::Dry::Monads[:result]
      include Import[:echo]

      def call(message)
        command = message.split(' ')[0]

        case command
        when '/echo'
          Success(echo)
        else
          Failure('Unknown command')
        end
      end
    end
  end
end
