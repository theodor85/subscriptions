# frozen_string_literal: true

require 'pry'
require_relative './app'

map('/') { run App }
