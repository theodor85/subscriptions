require 'dry/monads'
require_relative './tg_objects/update'

module Subscriptions
  class Router
    include ::Dry::Monads[:result, :do]
    include Import[:state_machine]

    attr_reader :update

    def call(params)
      puts '****** inside router'
      construct_update_object(params)
      return nil if update.nil?
      return nil unless update_has_message?

      current_state, current_data = yield state_machine.get_current_state(user_id:)
      operation = yield state_machine.get_operation(current_state, update)
      answer, next_state, data = yield operation.(update:, current_data:)
      yield state_machine.save_state(user_id:, state: next_state, data:)

      Success(answer)
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

    def user_id
      update.message.from.id
    end
  end
end
