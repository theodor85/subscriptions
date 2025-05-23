# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Do nothing command', type: :router do
  it 'returns nothing' do
    result = send_text_message('/asfasf!')
    expect(result).to be_success
    expect(result.value!).to be_nil
  end
end
