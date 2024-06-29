# frozen_string_literal: true
require 'dry/monads'

module Subscriptions
  module Http
    class Client
      include ::Dry::Monads[:result]
      include Import['http_connection']

      def call(url, method, params=nil, headers=nil)
        reponse = http_connection.send(method, url, params.to_json, headers)

        if reponse.status == 200
          Success()
        else
          Failure({code: :request_failed, message: reponse.status})
        end
      rescue Faraday::Error => e
        Failure({code: :connection_error, message: e.message})
      end
    end
  end
end
