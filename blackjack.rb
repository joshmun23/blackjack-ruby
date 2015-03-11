#!/usr/bin/env ruby
require_relative 'models/deck'
require_relative 'models/card'
require_relative 'models/hand'

require 'pry'

game = Hand.new
game.new_game

game.current_round
# binding.pry
