# frozen_string_literal: true

require_relative '../base'

module Operations
  module Initial
    class Start < Base
      private

      def action
        @answer = answer
        @next_state = :initial
        @data = {}

        Success()
      end

      def find_or_create_user
        User.find_or_create_by(
          telegram_id: update.message.from.id
        )
      rescue StandardError => e
        puts "*** Error finding or creating user: #{e.message}"
        Failure("Error finding or creating user: #{e.message}")
      end

      def answer
        TgObjects::Answer.new(
          tg_method: 'sendMessage',
          answer_body: TgObjects::AnswerBody.new(
            chat_id: update.message.chat.id,
            text: 'Добро пожаловать!',
          )
        )
      end
    end
  end
end
