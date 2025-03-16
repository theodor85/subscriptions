# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Send something to webhook endpoint' do
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
        text: 'something',
      }
    }
  end

  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }

  it 'returns ok' do
    post "/#{ENV['WEBHOOK_ENDPOINT']}", request_body.to_json, headers

    expect(last_response).to be_ok
    expect(last_response.body).to eq('ok')
  end
end
