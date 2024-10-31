# frozen_string_literal: true

require 'dry-struct'
require_relative 'symbolize_struct'
require_relative 'user'
require_relative 'message'

module Subscriptions
  module TgObjects
    class CallbackQuery < SymbolizeStruct
      attribute :id, Types::String
      attribute :from do
        attributes_from User
      end
      attribute? :message do
        attributes_from Message
      end
      attribute :chat_instance, Types::String
      attribute? :data, Types::String
    end
  end
end
