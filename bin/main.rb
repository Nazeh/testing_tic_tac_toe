# frozen_string_literal: true

require_relative '../lib/game.rb'
require_relative '../lib/ui.rb'

# Initiate players
player1 = Player.new('player 1')
player2 = Player.new('player 2')

loop do
  # initiate game
  game = Game.new(player1, player2)

  Engine.play(game) while game.status == 'continue'

  break unless Engine.play_again?
end

# thanks for playing
Ui.thanks
