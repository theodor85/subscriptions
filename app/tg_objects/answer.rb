# frozen_string_literal: true

require 'dry-struct'
require_relative 'answer_body'

module TgObjects
  class Answer < SymbolizeStruct
    attribute :tg_method, Types::String
    attribute :answer_body do
      attributes_from AnswerBody
    end
  end
end
