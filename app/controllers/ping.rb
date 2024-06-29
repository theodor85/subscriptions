# frozen_string_literal: true

module Subscriptions
  module Controllers
    class Ping
      include Import[:telegram]

      def call(params)
        telegram.send_message(chat_id, params['message'])
      end

      private

      def chat_id
        '639085762'
      end
    end
  end
end
