require 'dry/monads'
require_relative './tg_objects/update'

class Router
  include ::Dry::Monads[:result, :do]
  include Import[
    'state_machine.get_current_state',
    'state_machine.get_operation',
    'state_machine.save_state',
  ]

  attr_reader :update

  def call(params)
    puts '****** inside router'
    construct_update_object(params)

    state, current_data = yield get_current_state.(user_id:)
    puts "********** state=#{state}"
    current_operation = yield get_operation.(state:, update:)
    puts "********** operation=#{current_operation}"
    answer, next_state, data = yield current_operation.(update:, current_data:)
    yield save_state.(user_id:, state: next_state, data:)

    Success(answer)
  end

  private

  def construct_update_object(params)
    puts "**********construct_update_object params=#{params}"
    @update = TgObjects::Update.new(params[:update])
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
