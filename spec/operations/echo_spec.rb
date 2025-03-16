# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Echo command', type: :router do
  let(:chat_id) { 1 }
  let(:answer) do
    TgObjects::Answer.new(
      tg_method: 'sendMessage',
      answer_body: TgObjects::AnswerBody.new(
        chat_id:,
        text: 'Echo',
        reply_markup:,
      )
    )
  end

  let(:reply_markup) do
    TgObjects::ReplyMarkup.new(inline_keyboard:)
  end

  let(:inline_keyboard) do
    [[
      TgObjects::InlineKeyboardButton.new(
        text: 'Выключить',
        callback_data: 'off'
      ),
      TgObjects::InlineKeyboardButton.new(
        text: 'Вернуться',
        callback_data: 'back'
      )
    ]]
  end

  let(:answer_error) do
    TgObjects::Answer.new(
      tg_method: 'sendMessage',
      answer_body: TgObjects::AnswerBody.new(
        chat_id:,
        text: 'Неверная команда! Используйте кнопки Включить/Выключить и Вернуться'
      )
    )
  end

  it 'returns error message if no answer after second step' do
    result = send_text_message('/echo')
    expect(result.value!).to eq(answer)
    expect(current_state).to eq('qwestion')

    result = send_text_message('Something')
    expect(result.value!).to eq(answer_error)
    expect(current_state).to eq('qwestion')
  end
end
