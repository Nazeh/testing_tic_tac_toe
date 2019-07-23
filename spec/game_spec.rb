# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  describe '#initialize' do
    it 'will initiate readable @status = "continue"' do
      expect(subject.status).to eq('continue')
    end
    it 'will initiate readable @moves = Zero' do
      expect(subject.moves).to eq(0)
    end
    it 'will initiate readable @turn = 1' do
      expect(subject.turn).to eq(0)
    end
  end

  describe '#update' do
    increments = (0..15).to_a.sample
    increments.times do
      before { subject.update }
    end
    it 'will incriment on @moves' do
      expect(subject.moves).to eq(increments)
    end
    it 'will switch @turn' do
      expect(subject.turn).to eq(increments % 2)
    end
  end

  describe '#check_status' do
    it 'will return and set @status to "draw" after 9 moves' do
      9.times { subject.update }
      expect(subject.check_status([], 'X')).to eq('draw')
      expect(subject.status).to eq('draw')
    end

    let(:mark) { %w[X O].sample }
    it 'will return and set @status to "win" if any col, row or diagonal contain 3 instances of mark' do
      row_col_diagonals_test = [
        [4, mark, 6],
        [2, mark, 8],
        [mark, mark, mark],
        [3, mark, 7]
      ]

      expect(subject.check_status(row_col_diagonals_test, mark)).to eq('win')
      expect(subject.status).to eq('win')
    end
  end
end
