# frozen_string_literal: true

module Subscriptions
  module Operations
    class Base
      include ::Dry::Monads[:result]

      attr_reader :update, :current_data

      def call(update:, current_data:)
        @update = update
        @current_data = current_data

        Success([answer, next_state, data])
      end

      protected

      def answer
        raise NotImplementedError
      end

      def next_state
        raise NotImplementedError
      end

      def data
        raise NotImplementedError
      end
    end
  end
end
