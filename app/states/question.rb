# frozen_string_literal: true

require_relative 'base'

module States
  class Question < Base
    include Import[
      'operations.question.turn_off',
      'operations.question.turn_on',
      'operations.question.error',
      'operations.question.return_to_main'
    ]

    private

    def operation
      return error unless update.callback_query

      choose_operation
    end

    def choose_operation
      case update.callback_query.data
      when 'off'
        turn_off
      when 'on'
        turn_on
      when 'back'
        return_to_main
      else
        error
      end
    end
  end
end
