# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  # random alphanumerical player names
  let(:player_name) { [*('A'..'Z'), *('0'..'9')].sample(8).join.to_s }
  subject { Player.new(player_name) }

  describe '#initialize' do
    it 'will set readable attr @player_name' do
      expect(subject.name).to eql(player_name)
    end
    it 'will set readable attr @score to Zero' do
      expect(subject.score).to eql(0)
    end
  end

  describe '#add_mark' do
    mark = %w[X O].sample
    color = mark == 'X' ? '31' : '32' # red : green
    before { subject.add_mark(mark) }

    it 'will set readable attr @mark' do
      expect(subject.mark).to eql(mark)
    end
    it 'will set readable attr @color according to @mark' do
      expect(subject.color).to eql(color)
    end
  end

  describe '#add_score' do
    score = (0..15).to_a.sample
    score.times do
      before { subject.add_score }
    end
    it 'will add one to attr @score' do
      expect(subject.score).to eq(score)
    end
  end
end
