# frozen_string_literal: true

require_relative 'base'

module Subscriptions
  module States
    class Initial < Base
      include Import[
        'operations.echo'
      ]

      private

      def operation
        return unless update.message.text == '/echo'

        echo
      end
    end
  end
end
