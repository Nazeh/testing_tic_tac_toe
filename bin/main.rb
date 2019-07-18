# frozen_string_literal: true

require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

# Initiate players
player1 = Player.new('player 1')
player2 = Player.new('player 2')

# initiate game
game = Game.new(player1, player2)

loop do
  game.new_match
  game.play while game.status == 'continue'
  break unless game.play_again?
end

# thanks for playing
Ui.thanks
