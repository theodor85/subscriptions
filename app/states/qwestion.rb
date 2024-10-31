# frozen_string_literal: true

require_relative 'base'

module Subscriptions
  module States
    class Qwestion < Base
      include Import[
        'operations.turn_off',
        'operations.turn_on',
        'operations.error',
        'operations.return_to_main'
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
end
