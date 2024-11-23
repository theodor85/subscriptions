# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Echo' do
  describe 'Echo command', type: :sending_messages do
    it 'returns the same message for the request' do
      send_text_message('/echo Hello, world!')

      expect(last_response).to be_ok
      expect(last_response.body).to eq 'ok'
      expect(http_client).to answer_is('Возвращаем вам ваше сообщение: Hello, world!')
    end

    it 'returns 404 for root get request' do
      get '/'

      expect(last_response.status).to eq 404
    end
  end
end
