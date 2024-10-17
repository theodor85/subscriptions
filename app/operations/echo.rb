require_relative 'base'

module Subscriptions
  module Operations
    class Echo < Base
      private

      def answer
        "Возвращаем вам ваше сообщение: #{message.split(' ')[1..].join(' ')}"
      end

      def next_state
        :initial
      end

      def data
        {}
      end

      def message
        update.message.text
      end
    end
  end
end
