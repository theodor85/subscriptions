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

  let(:redis) { Redis.new(url: ENV['REDIS_URL']) }

  before do
    redis.flushdb
  end

  def send_text_message(text)
    request_body[:message][:text] = text

    router.(update: request_body)
  end

  def answer_is
    return nil if http_client_calls.empty?

    http_client_calls.last[2]
  end

  def current_state
    redis.get('1_state')
  end
end
