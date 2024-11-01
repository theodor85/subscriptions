# frozen_string_literal: true

require 'dry-struct'
require_relative 'symbolize_struct'
require_relative 'callback_query'
require_relative 'message'

module TgObjects
  class Update < SymbolizeStruct
    attribute :update_id, Types::Integer
    attribute? :message do
      attributes_from Message
    end

    attribute? :edited_message do
      attributes_from Message
    end

    attribute? :callback_query do
      attributes_from CallbackQuery
    end
  end
end
