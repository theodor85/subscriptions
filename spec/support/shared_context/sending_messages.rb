# frozen_string_literal: true

require 'redis'
require_relative '../../../app/http/client'

RSpec.shared_context 'when sending messages' do
  let(:request_body) do
    {
      update_id: 1,
      message: {
        message_id: 1,
        from: {
          id: 1,
          is_bot: false,
          first_name: 'John',
        },
        chat: {
          id: 1,
          type: 'private',
        },
        date: 1,
        text: '',
      }
    }
  end

  let(:callback_query) do
    {
      update_id: 1,
      callback_query: {
        id: '1',
        from: {
          id: 1,
          is_bot: false,
          first_name: 'John',
        },
        message: {
          message_id: 1,
          from: {
            id: 1,
            is_bot: false,
            first_name: 'John',
          },
          chat: {
            id: 1,
            type: 'private',
          },
          date: 1_730_377_286,
          text: 'Echo',
        },
        chat_instance: '1',
        data: 'off'
      }
    }
  end

  let(:redis) { Redis.new(url: ENV['REDIS_URL']) }

  before do
    redis.flushdb
  end

  def send_text_message(text)
    request_body[:message][:text] = text

    router.(update: request_body)
  end

  def press_button(callback_data)
    callback_query[:callback_query][:data] = callback_data

    router.(update: callback_query)
  end

  def current_state
    redis.get('1_state')
  end
end
