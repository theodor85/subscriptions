require 'dry/monads'
require_relative './tg_objects/update'

module Subscriptions
  class Router
    attr_reader :update

    include ::Dry::Monads[:result, :do]
    include Import[:message_parser, :state_machine]

    def call(params)
      puts '****** inside router'
      construct_update_object(params)
      return nil if update.nil?
      return nil unless update_has_message?

      return { chat_id:, message: parse_result.failure } unless parse_result.success?

      current_state, current_data = yield state_machine.get_current_state(user_id:)
      operation = yield state_machine.get_operation(current_state, update)
      answer, next_state, data = yield operation.(update:, current_data:)
      yield state_machine.save_state(user_id:, state: next_state, data:)

      Success({ chat_id:, message: answer })
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

    def user_id
      update.message.from.id
    end
  end
end
