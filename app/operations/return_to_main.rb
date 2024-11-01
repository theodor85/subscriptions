# frozen_string_literal: true

require_relative 'base'
require_relative '../tg_objects/answer'
require_relative '../tg_objects/answer_body'

module Operations
  class ReturnToMain < Base
    private

    def answer
      TgObjects::Answer.new(
        tg_method: 'sendMessage',
        answer_body: TgObjects::AnswerBody.new(
          chat_id: update.callback_query.from.id,
          text: 'Вы вернулись в главное меню',
        )
      )
    end

    def next_state
      :initial
    end

    def data
      {}
    end
  end
end
