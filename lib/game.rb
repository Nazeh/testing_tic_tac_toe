# frozen_string_literal: true

require_relative '../lib/board'

# class Game Initiate @status, @moves, and @turn and able to increment on @moves, switch @turn
# as well as update the @status by examining a mark and row_col_diagonals of last cell marked.
class Game
  attr_reader :status
  attr_reader :board
  attr_reader :player1
  attr_reader :player2
  attr_reader :current_player

  def initialize(player1, player2)
    @status = 'continue'
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end

  def set_first_player(first_player)
    if first_player == 1
      @player1.add_mark('X')
      @player2.add_mark('O')
      @current_player = @player1
    else
      @player2.add_mark('X')
      @player1.add_mark('O')
      @current_player = @player2
    end
  end

  def next_move
    update
    cell = choose_cell
    @board.update(cell, @mark)
    update_status(@board.row_col_diagonals(cell), @mark)
  end

  private

  def update
    @moves += 1
    @mark = %w[X O][@moves % 2]
    @current_player = players[@moves % 2]
  end

  def update_status(row_col_diagonals, mark)
    @status = 'draw' if @moves >= 8
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
  end
end
