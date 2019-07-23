# frozen_string_literal: true

require_relative '../lib/board.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ui.rb'

# class Game Initiate a new board (using Board class) and status,
# plays one match, and update the UI (using Ui module) and change
# the player score in the mean time.
class Game
  attr_reader :status

  def initialize
    @status = 'continue'
    @moves = 0
    @turn = 0
  end

  def iterate
    @moves += 1
    @turn += 1
  end

  def update_status(row_col_diagonals, mark)
    @status = 'draw' if @moves >= 9
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
    @status
  end
end
