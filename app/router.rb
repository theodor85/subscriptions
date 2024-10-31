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

      current_state, current_data = yield state_machine.get_current_state(user_id:)
      puts "********** current_state=#{current_state}"
      operation = yield state_machine.get_operation(current_state, update)
      puts "********** operation=#{operation}"
      answer, next_state, data = yield operation.(update:, current_data:)
      yield state_machine.save_state(user_id:, state: next_state, data:)

      Success(answer)
    end

    private

    def construct_update_object(params)
      puts "**********construct_update_object params=#{params}"
      @update = Subscriptions::TgObjects::Update.new(params[:update])
    rescue Dry::Struct::Error => e
      puts "**********construct_update_object error=#{e}"
      @update = nil
    end

    def user_id
      return update.message&.from&.id if update.message
      return update.edited_message&.from&.id if update.edited_message

      update.callback_query&.from&.id
    end
  end
end
