# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Echo command', type: :sending_messages do
  let(:answer_body) do
    {
      chat_id: 1,
      text: 'Echo',
      reply_markup: {
        inline_keyboard: [
          [
            {
              text: 'Выключить',
              callback_data: 'off'
            },
            {
              text: 'Вернуться',
              callback_data: 'back'
            }
          ]
        ]
      }
    }
  end

  let(:answer_error) do
    { chat_id: 1, text: 'Неверная команда! Используйте кнопки Включить/Выключить и Вернуться' }
  end

  it 'returns the same message for the request' do
    send_text_message('/echo')

    expect(answer_is).to eq(answer_body)
    expect(current_state).to eq('qwestion')

    send_text_message('Echo')
    expect(answer_is).to eq(answer_error)
    expect(current_state).to eq('qwestion')
  end
end
