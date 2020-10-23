# frozen_string_literal: true

# NOTICE: Please ensure simplecov is required at the top of this file
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'

require_relative '../lib/api'
require_relative '../lib/parsers/indie_music_parser'
