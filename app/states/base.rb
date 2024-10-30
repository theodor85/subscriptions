# frozen_string_literal: true

module Subscriptions
  module States
    class Base
      include ::Dry::Monads[:result]

      attr_reader :update

      def call(update)
        @update = update

        return Success(operation) if operation

        Failure('Unknown command')
      end

      protected

      def operation
        raise NotImplementedError
      end
    end
  end
end
