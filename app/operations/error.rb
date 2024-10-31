# frozen_string_literal: true

require_relative 'base'
require_relative '../tg_objects/answer'
require_relative '../tg_objects/answer_body'

module Subscriptions
  module Operations
    class Error < Base
      private

      def answer
        Subscriptions::TgObjects::Answer.new(
          tg_method: 'sendMessage',
          answer_body: Subscriptions::TgObjects::AnswerBody.new(
            chat_id: update.message.chat.id,
            text: 'Неверная команда! Используйте кнопки Включить/Выключить и Вернуться'
          )
        )
      end

      def next_state
        :qwestion
      end

      def data
        {}
      end
    end
  end
end
