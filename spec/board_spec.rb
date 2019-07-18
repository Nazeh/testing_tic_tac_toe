# frozen_string_literal: true

require_relative '../lib/board.rb'

RSpec.describe Board do
  let(:new_board) { Board.new }

  describe '#initialize' do
    subject { new_board.board }
    it { should be_eql([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) }
  end

  describe '#update' do
    let(:mark) { 'X' }
    subject { new_board.board }

    context 'When mark cell 4, board:' do
      let(:cell) { 4 }
      before { new_board.update(cell, mark) }
      it { should be_eql([[1, 2, 3], ['X', 5, 6], [7, 8, 9]]) }
    end

    context 'When mark cell 9, board:' do
      let(:cell) { 9 }
      before { new_board.update(cell, mark) }
      it { should be_eql([[1, 2, 3], [4, 5, 6], [7, 8, 'X']]) }
    end

    context 'When mark cell 1, while cell 5 is marked board:' do
      let(:cell) { 1 }
      before { new_board.update(5, 'O') }
      before { new_board.update(cell, mark) }
      it { should be_eql([['X', 2, 3], [4, 'O', 6], [7, 8, 9]]) }
    end
  end

  describe '#get_row_col_diagonals' do
    subject { new_board.get_row_col_diagonals(cell) }
    before { new_board.update(1, 'O') }
    before { new_board.update(5, 'X') }
    before { new_board.update(3, 'O') }

    context 'When cell is 5 (row 2 col 2)' do
      let(:cell) { 5 }
      it { should be_eql([[4, 'X', 6], [2, 'X', 8], ['O', 'X', 9], ['O', 'X', 7]]) }
    end
    context 'When cell is 1 (row 1 col 1)' do
      let(:cell) { 1 }
      it { should be_eql([['O', 2, 'O'], ['O', 4, 7], ['O', 'X', 9]]) }
    end
    context 'When cell is 7 (row 3 col 1)' do
      let(:cell) { 7 }
      it { should be_eql([[7, 8, 9], ['O', 4, 7], ['O', 'X', 7]]) }
    end
    context 'When cell is 3 (row 1 col 3)' do
      let(:cell) { 3 }
      it { should be_eql([['O', 2, 'O'], ['O', 6, 9], ['O', 'X', 7]]) }
    end
    context 'When cell is even (row 2 col 3)' do
      let(:cell) { 6 }
      it { should be_eql([[4, 'X', 6], ['O', 6, 9]]) }
    end
  end
end
