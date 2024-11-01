# frozen_string_literal: true

require_relative 'base'

module Operations
  class DoNothing < Base
    private

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
