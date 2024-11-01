# frozen_string_literal: true

require 'dry-struct'

require_relative 'inline_keyboard_button'

module TgObjects
  class ReplyMarkup < SymbolizeStruct
    attribute? :inline_keyboard, Types::Array.of(Types::Array.of(InlineKeyboardButton))
  end
end
