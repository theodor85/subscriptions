# frozen_string_literal: true
require_relative '../tg_objects/update'

module Subscriptions
  module Controllers
    class UpdateHandler
      include Import[:telegram]

      def call(update)
        update_struct = Subscriptions::TgObjects::Update.new(update)
        telegram.send_message(update_struct.message.chat.id,
                              message(update_struct.message.text))
      end

      private

      def message(text)
        "Вы прислали: #{text}"
      end
    end
  end
end
