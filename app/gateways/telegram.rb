# frozen_string_literal: true
require 'dry/monads'

module Subscriptions
  module Gateways
    class Telegram
      include ::Dry::Monads[:result]
      include Import['http_client', 'config']

      def send_message(chat_id, message)
        @chat_id = chat_id
        @message = message

        http_client.(config.tg_url + '/sendMessage', :post, message_body, headers)
      end

      private

      def message_body
        {
          chat_id: @chat_id,
          text: @message,
        }
      end

      def headers
        {"Content-Type" => "application/json"}
      end
    end
  end
end
