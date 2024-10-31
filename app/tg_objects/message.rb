# frozen_string_literal: true

require 'dry-struct'
require_relative 'symbolize_struct'
require_relative 'chat'
require_relative 'user'

module Subscriptions
  module TgObjects
    class Message < SymbolizeStruct
      attribute :message_id, Types::Integer

      attribute? :from do
        attributes_from User
      end

      attribute? :chat do
        attributes_from Chat
      end

      attribute :date, Types::Integer
      attribute :text, Types::String
    end
  end
end
