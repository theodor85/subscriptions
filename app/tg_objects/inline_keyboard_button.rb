# frozen_string_literal: true

require 'dry-struct'

module TgObjects
  class InlineKeyboardButton < SymbolizeStruct
    attribute :text, Types::String
    attribute? :url, Types::String
    attribute? :callback_data, Types::String
  end
end
