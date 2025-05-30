# frozen_string_literal: true

require_relative 'base'

module States
  class Initial < Base
    include Import[
      'operations.initial.echo',
      'operations.initial.do_nothing',
      'operations.initial.start',
    ]

    private

    def operation
      return start if update.message&.text == '/start'
      return do_nothing unless update.message&.text == '/echo'

      echo
    end
  end
end
