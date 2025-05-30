# frozen_string_literal: true

require_relative '../base'

module Operations
  module Initial
    class DoNothing < Base
      private

      def action
        @answer = nil
        @next_state = :initial
        @data = {}

        Success()
      end

      def answer
        nil
      end

      def next_state
        :initial
      end

      def data
        {}
      end
    end
  end
end
