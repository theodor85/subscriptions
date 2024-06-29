# frozen_string_literal: true

require 'dry/monads'

module Subscriptions
  module Telegram
    class Sender
      include ::Dry::Monads[:result]
      include Import[:http_client, :config]

      def call(chat_id, message)
        @chat_id = chat_id
        @message = message

        http_client.("#{config.tg_url}/sendMessage", :post, message_body)
      end

      private

      def message_body
        {
          chat_id: @chat_id,
          text: @message,
        }
      end
    end
  end
end
