# frozen_string_literal: true

# class Game Initiate @status, @moves, and @turn and able to increment on @moves, switch @turn
# as well as update the @status by examining a mark and row_col_diagonals of last cell marked.
class Game
  attr_reader :status
  attr_reader :moves
  attr_reader :turn

  def initialize
    @status = 'continue'
    @moves = 0
    @turn = 0
  end

  def update
    @moves += 1
    @turn = (@turn.zero? ? 1 : 0)
  end

  def check_status(row_col_diagonals, mark)
    @status = 'draw' if @moves >= 9
    @status = 'win' if row_col_diagonals.any? { |element| element.count(mark) == 3 }
    @status
  end
end
