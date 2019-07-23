# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  # random alphanumerical player names
  let(:player_name) { [*('A'..'Z'), *('a'..'z'), *('0'..'9')].sample(8).join.to_s }
  subject { Player.new(player_name) }

  describe '#initialize' do
    it 'will set readable attr @player_name to any alphanumerical value' do
      expect(subject.name).to eql(player_name)
    end
    it 'will set readable attr @score to Zero' do
      expect(subject.score).to eql(0)
    end
  end

  describe '#add_mark' do
    context 'when given a mark X or O' do
      mark = %w[X O].sample
      color = mark == 'X' ? '31' : '32' # red : green
      before { subject.add_mark(mark) }

      it 'will set readable attr @mark to X or O' do
        expect(subject.mark).to eql(mark)
      end
      it 'will set readable attr @color according to @mark' do
        expect(subject.color).to eql(color)
      end
    end

    context 'when given a mark other than X or O' do
      mark = ([*('A'..'Z'), *('a'..'z'), *('0'..'9')] - %w[X O]).sample
      it 'will return false and mark will stay nil' do
        expect(subject.add_mark(mark)).to be false
        expect(subject.mark).to be nil
      end
    end
  end

  describe '#add_score' do
    increments = (0..15).to_a.sample
    increments.times do
      before { subject.add_score }
    end
    it 'will add increment attr @score' do
      expect(subject.score).to eq(increments)
    end
  end
end
