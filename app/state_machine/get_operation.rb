# frozen_string_literal: true

module StateMachine
  class GetOperation
    include Import[
      'states.initial',
      'states.question'
    ]

    def call(state:, update:)
      send(state).call(update)
    end
  end
end
