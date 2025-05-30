# frozen_string_literal: true

require_relative '../base'
require_relative '../../tg_objects/answer'
require_relative '../../tg_objects/answer_body'

module Operations
  module Question
    class Error < Base
      private

      def action
        @answer = answer
        @next_state = next_state
        @data = data

        Success()
      end

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
        :question
      end

      def data
        {}
      end
    end
  end
end
