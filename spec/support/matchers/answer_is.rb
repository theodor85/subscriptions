# # frozen_string_literal: true

# RSpec::Matchers.define :answer_is do |expected_answer|
#   match do |http_client|
#     puts "!!!!!!!!!!! http_client_calls=#{http_client_calls}"

#     if expected_answer
#       expect(http_client).to have_received(:call).exactly(http_client_calls.length).times

#       expect(http_client).to have_received(:call).with(
#         "#{ENV['TG_URL']}/sendMessage",
#         :post,
#         expected_answer,
#       )
#     else
#       expect(http_client).not_to have_received(:call)
#     end
#   end

#   failure_message do |http_client|
#     "expected that received message is '#{expected_answer}', but got something different"
#   end
# end
