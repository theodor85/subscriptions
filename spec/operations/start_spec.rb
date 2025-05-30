# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Start command', type: :router do
  context 'when user does not exist' do
    let(:result) { send_text_message('/start') }
    let(:answer_body) { result.value!.answer_body }

    it 'answers with a welcome message' do
      expect(result).to be_success
      expect(answer_body).to be_a(TgObjects::Answer::AnswerBody)
      expect(answer_body.text).to include('Добро пожаловать')
    end

    it 'turns the current state to "initial"' do
      expect(result).to be_success
      expect(current_state).to eq('initial')
    end

    it 'creates a new user' do
      expect(result).to be_success
      user = User.first
      expect(user).to be_present
    end
  end
end
