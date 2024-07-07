RSpec::Matchers.define :answer_is do |expected|
  match do |http_client|
    expect(http_client).to have_received(:call).with("#{ENV['TG_URL']}/sendMessage", :post, { chat_id: 1, text: expected })
  end

  failure_message do |http_client|
    "expected that received message is '#{expected}', but got somthing different"
  end
end
