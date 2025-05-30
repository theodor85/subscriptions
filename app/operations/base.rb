# frozen_string_literal: true

module Operations
  class Base
    include ::Dry::Monads[:result, :do]

    attr_reader :update, :current_data, :answer, :next_state, :data

    def call(update:, current_data:)
      @update = update
      @current_data = current_data

      yield action

      Success([answer, next_state, data])
    end

    protected

    def action
      raise NotImplementedError, "#{self.class} must implement the action method"
    end
  end
end
