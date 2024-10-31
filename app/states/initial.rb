# frozen_string_literal: true

require_relative 'base'

module Subscriptions
  module States
    class Initial < Base
      include Import[
        'operations.echo',
        'operations.do_nothing',
      ]

      private

      def operation
        return do_nothing unless update.message&.text == '/echo'

        echo
      end
    end
  end
end
