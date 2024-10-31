# frozen_string_literal: true

require_relative 'base'
require_relative '../tg_objects/answer'
require_relative '../tg_objects/answer_body'
require_relative '../tg_objects/reply_markup'
require_relative '../tg_objects/inline_keyboard_button'

module Subscriptions
  module Operations
    class Echo < Base
      private

      def answer
        Subscriptions::TgObjects::Answer.new(
          tg_method: 'sendMessage',
          answer_body: Subscriptions::TgObjects::AnswerBody.new(
            chat_id: update.message.chat.id,
            text: 'Echo',
            reply_markup:
          )
        )
      end

      def next_state
        :initial
      end

      def data
        {}
      end

      def reply_markup
        Subscriptions::TgObjects::ReplyMarkup.new(inline_keyboard:)
      end

      def inline_keyboard
        [[
          Subscriptions::TgObjects::InlineKeyboardButton.new(
            text: 'Выключить',
            callback_data: 'off'
          ),
          Subscriptions::TgObjects::InlineKeyboardButton.new(
            text: 'Вернуться',
            callback_data: 'back'
          )
        ]]
      end
    end
  end
end
