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

        puts '********** before response'
        response = http_client.("#{config.tg_url}/sendMessage", :post, message_body)

        puts "*********** reponse=#{response}"

        response
      end

      private

      def message_body
        {
          chat_id: @chat_id,
          text: @message,
          reply_markup: {
            inline_keyboard: [
              [{ text: 'echo', url: 'https://www.google.com' }],
              [{ text: 'help', url: 'https://www.google.com' }]
            ],
          }
        }
      end
    end
  end
end
