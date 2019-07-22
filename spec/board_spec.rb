# frozen_string_literal: true

require_relative '../lib/board'

RSpec.describe Board do
  let(:board) { subject.board }
  let(:mark) { %w[X O].sample }

  describe '#initialize' do
    it 'will initiate readable 2D array attr : board' do
      expect(subject.board).to eq([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    end
  end

  # helper methods
  def row(cell)
    (cell - 1) / 3
  end

  def col(cell)
    (cell - 1) % 3
  end

  describe '#update' do
    cell = (1..9).to_a.sample
    it 'will return false if cell is already marked' do
      subject.update(cell, mark)
      expect(subject.update(cell, mark)).to be_falsey
    end
    it 'will update any cell in board' do
      subject.update(cell, mark)
      expect(board[row(cell)][col(cell)]).to eq(mark)
    end
  end

  describe '#get_row_col_diagonals' do
    context 'When cell == 5' do
      cell = 5
      it 'will return row, col, and two diagonals' do
        expect(subject.get_row_col_diagonals(cell)).to eq(
          [
            [board[row(cell)][0], board[row(cell)][1], board[row(cell)][2]],
            [board[0][col(cell)], board[1][col(cell)], board[2][col(cell)]],
            [board[0][0], board[1][1], board[2][2]],
            [board[0][2], board[1][1], board[2][0]]
          ]
        )
      end
    end
    context 'When cell is even' do
      cell = [2, 4, 6, 8].sample
      it 'will return row col only' do
        expect(subject.get_row_col_diagonals(cell)).to eq(
          [
            [board[row(cell)][0], board[row(cell)][1], board[row(cell)][2]],
            [board[0][col(cell)], board[1][col(cell)], board[2][col(cell)]]
          ]
        )
      end
    end
    context 'When cell is 1 or 9' do
      cell = [1, 9].sample
      it 'will return row col and left to right diagonal' do
        expect(subject.get_row_col_diagonals(cell)).to eq(
          [
            [board[row(cell)][0], board[row(cell)][1], board[row(cell)][2]],
            [board[0][col(cell)], board[1][col(cell)], board[2][col(cell)]],
            [board[0][0], board[1][1], board[2][2]]
          ]
        )
      end
    end
    context 'When cell is 3 or 7' do
      cell = [3, 7].sample
      it 'will return row col and right to left diagonal' do
        expect(subject.get_row_col_diagonals(cell)).to eq(
          [
            [board[row(cell)][0], board[row(cell)][1], board[row(cell)][2]],
            [board[0][col(cell)], board[1][col(cell)], board[2][col(cell)]],
            [board[0][2], board[1][1], board[2][0]]
          ]
        )
      end
    end
  end
end
