require 'dry/monads'

module Subscriptions
  class Router
    include ::Dry::Monads[:result]
    include Import[:ping, :update_handler]

    def call(params)
      result = case params
      in {update: }
        update_handler.(update)
      else
        ping.(params)
      end

      case result
      in Success()
        'OK'
      in Failure({code:, message:})
        "Error: code=#{code} message=#{message}"
      end
    end
  end
end
