require_relative '../../../app/http/client'

RSpec.shared_context :sending_messages do
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
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:http_client) { double('Subscriptions::Http::Client') }

  before do
    allow(Subscriptions::Http::Client).to receive(:new).and_return(http_client)
    allow(http_client).to receive(:call)
  end

  def send_text_message(text)
    request_body[:message][:text] = text
    post "/#{ENV['WEBHOOK_ENDPOINT']}", request_body.to_json, headers
  end
end
