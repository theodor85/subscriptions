# frozen_string_literal: true

module StateMachine
  class GetOperation
    include Import[
      'states.initial',
      'states.qwestion'
    ]

    def call(state:, update:)
      send(state).call(update)
    end
  end
end
