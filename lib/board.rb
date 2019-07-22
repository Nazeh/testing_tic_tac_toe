# frozen_string_literal: true

# Board class initiate a 2D Array, and it can update it, fetch it
# and return the row, col and/or diagonals of any cell
class Board
  attr_reader :board

  def initialize
    @board = [[1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]]
  end

  def update(cell, mark)
    return false if @board[row_index(cell)][col_index(cell)].is_a?(String)
    @board[row_index(cell)][col_index(cell)] = mark
  end

  def get_row_col_diagonals(cell)
    row_col_diagonals = [get_row(cell), get_col(cell)]
    row_col_diagonals << get_diagonals(cell).first unless cell.even?
    row_col_diagonals << get_diagonals(cell).last if cell == 5
    row_col_diagonals
  end

  private

  def row_index(cell)
    (cell - 1) / 3
  end

  def col_index(cell)
    (cell - 1) % 3
  end

  def get_row(cell)
    board[row_index(cell)]
  end

  def get_col(cell)
    col = []
    @board.each { |row| col << row[col_index(cell)] }
    col
  end

  def diagonals_helpers
    @diagonal_cells = [[1, 5, 9], [3, 5, 7]]
    @diagonal_values = [[@board[0][0], @board[1][1], @board[2][2]], [@board[0][2], @board[1][1], @board[2][0]]]
  end

  def get_diagonals(cell)
    diagonals = []
    diagonals_helpers
    diagonals << @diagonal_values[0] if @diagonal_cells[0].include?(cell)
    diagonals << @diagonal_values[1] if @diagonal_cells[1].include?(cell)
    diagonals
  end
end
