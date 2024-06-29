# frozen_string_literal: true
require 'dry-struct'

module Subscriptions
  module TgObjects
    module Types
      include Dry.Types()
    end

    class SymbolizeStruct < Dry::Struct
      transform_keys(&:to_sym)
    end

    class User < SymbolizeStruct
      transform_keys(&:to_sym)

      attribute :id, Types::Integer
      attribute :is_bot, Types::Bool
      attribute :first_name, Types::String
      attribute? :last_name, Types::String
      attribute? :username, Types::String
      attribute? :language_code, Types::String
    end

    class Chat < SymbolizeStruct
      transform_keys(&:to_sym)

      attribute :id, Types::Integer
      attribute? :first_name, Types::String
      attribute? :last_name, Types::String
      attribute? :username, Types::String
      attribute :type, Types::String
    end

    class Update < SymbolizeStruct
      transform_keys(&:to_sym)

      attribute :update_id, Types::Integer
      attribute? :message do
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

      attribute? :edited_message do
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
end
