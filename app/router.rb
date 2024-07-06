require 'dry/monads'
require_relative './tg_objects/update'

module Subscriptions
  class Router
    attr_reader :update

    include ::Dry::Monads[:result]
    include Import[:message_parser]

    def call(params)
      construct_update_object(params)
      return nil if update.nil?
      return nil unless update_has_message?

      return { chat_id:, message: parse_result.failure } unless parse_result.success?

      case operation.(update.message.text)
      in Success(answer)
        { chat_id:, message: answer }
      in Failure(error)
        { chat_id:, message: error }
      end
    end

    private

    def construct_update_object(params)
      @update = Subscriptions::TgObjects::Update.new(params[:update])
    rescue Dry::Struct::Error
      @update = nil
    end

    def update_has_message?
      !update.message.nil?
    end

    def chat_id
      update.message.chat.id
    end

    def parse_result
      message_parser.(update.message.text)
    end

    def operation
      parse_result.value!
    end
  end
end
