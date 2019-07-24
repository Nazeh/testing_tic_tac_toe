# frozen_string_literal: true

require_relative '../lib/ui'
require_relative '../lib/player'
require_relative '../lib/game'

# start UI
Ui.display

# Initiate players to track score
player1 = Player.new(Ui.prompt_name('Player 1'))
player2 = Player.new(Ui.prompt_name('Player 2'))

loop do
  # choose who plays first
  first_player = Ui.prompt_first_player(player1, player2)

  # initiate new game
  game = game.new(player1, player2, first_player)

  # play game
  while game.status == 'continue'
    cell = Ui.prompt_cell(game)
    game.next_move(cell)
  end

  break unless Ui.play_again?(game)

  # update players score for next game
  player1 = game.player1
  player2 = game.player2
end

# thanks for playing
Ui.thanks
