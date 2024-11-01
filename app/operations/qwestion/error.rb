# frozen_string_literal: true

require_relative '../base'
require_relative '../../tg_objects/answer'
require_relative '../../tg_objects/answer_body'

module Operations
  module Qwestion
    class Error < Base
      private

      def answer
        TgObjects::Answer.new(
          tg_method: 'sendMessage',
          answer_body: TgObjects::AnswerBody.new(
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
