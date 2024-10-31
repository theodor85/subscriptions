# frozen_string_literal: true

require 'dry-struct'
require_relative 'reply_markup'

module Subscriptions
  module TgObjects
    class AnswerBody < SymbolizeStruct
      attribute :chat_id, Types::Integer
      attribute :text, Types::String
      attribute? :reply_markup do
        attributes_from ReplyMarkup
      end
    end
  end
end
