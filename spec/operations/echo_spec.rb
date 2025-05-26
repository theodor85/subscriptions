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

  let(:answer_for_press_turn_off) do
    TgObjects::Answer.new(
      tg_method: 'editMessageReplyMarkup',
      answer_body: TgObjects::AnswerBody.new(
        chat_id:,
        message_id: 1,
        reply_markup: reply_markup_for_press_turn_off
      )
    )
  end

  let(:reply_markup_for_press_turn_off) do
    TgObjects::ReplyMarkup.new(inline_keyboard: inline_keyboard_for_press_turn_off)
  end

  let(:inline_keyboard_for_press_turn_off) do
    [[
      TgObjects::InlineKeyboardButton.new(
        text: 'Включить',
        callback_data: 'on'
      ),
      TgObjects::InlineKeyboardButton.new(
        text: 'Вернуться',
        callback_data: 'back'
      )
    ]]
  end

  let(:answer_for_press_turn_on) do
    TgObjects::Answer.new(
      tg_method: 'editMessageReplyMarkup',
      answer_body: TgObjects::AnswerBody.new(
        chat_id:,
        message_id: 1,
        reply_markup: reply_markup_for_press_turn_on
      )
    )
  end

  let(:reply_markup_for_press_turn_on) do
    TgObjects::ReplyMarkup.new(inline_keyboard: inline_keyboard_for_press_turn_on)
  end

  let(:inline_keyboard_for_press_turn_on) do
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

  let(:answer_back) do
    TgObjects::Answer.new(
      tg_method: 'sendMessage',
      answer_body: TgObjects::AnswerBody.new(
        chat_id:,
        text: 'Вы вернулись в главное меню',
      )
    )
  end

  it 'returns error message if no answer after second step' do
    result = send_text_message('/echo')
    expect(result.value!).to eq(answer)
    expect(current_state).to eq('question')

    result = send_text_message('Something')
    expect(result.value!).to eq(answer_error)
    expect(current_state).to eq('question')
  end

  it 'happy path: echo, turn off, turn on, back' do
    result = send_text_message('/echo')
    expect(result.value!).to eq(answer)
    expect(current_state).to eq('question')

    result = press_button('off')
    expect(result.value!).to eq(answer_for_press_turn_off)
    expect(current_state).to eq('question')

    result = press_button('on')
    expect(result.value!).to eq(answer_for_press_turn_on)
    expect(current_state).to eq('question')

    result = press_button('back')
    expect(result.value!).to eq(answer_back)
    expect(current_state).to eq('initial')
  end
end
