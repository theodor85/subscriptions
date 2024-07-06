module Subscriptions
  module Operations
    class Echo
      include ::Dry::Monads[:result]

      def call(message)
        Success("Возвращаем вам ваше сообщение: #{message.split(' ')[1..].join(' ')}")
      end
    end
  end
end
