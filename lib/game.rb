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

  def initialize(player1, player2, first_player)
    @status = 'continue'
    @board = Board.new
    @player1 = player1
    @player2 = player2
    @moves = 0
    assign_marks(first_player)
  end

  def next_move(cell)
    mark = @current_player.mark
    @board.update(cell, mark)
    @moves += 1
    update_status(@board.row_col_diagonals(cell), mark)
    switch_players if @status == 'continue'
  end

  private

  def assign_marks(first_player)
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

  def switch_players
    @current_player = ([@player1, @player2] - [@current_player]).first
  end

  def update_status(row_col_diagonals, mark)
    @status = 'draw' if @moves >= 9
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
  end
end
