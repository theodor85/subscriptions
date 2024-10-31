# frozen_string_literal: true

require 'dry/monads'

module Subscriptions
  module Telegram
    class Sender
      include ::Dry::Monads[:result]
      include Import[:http_client, :config]

      def call(answer)
        puts '********** before response'
        puts "********** answer.to_h=#{answer.to_h}" if answer
        return unless answer

        response = http_client.("#{config.tg_url}/#{answer.tg_method}", :post, answer.answer_body.to_h)

        puts "*********** reponse=#{response}"

        response
      end
    end
  end
end
