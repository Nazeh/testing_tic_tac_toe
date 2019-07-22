# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

RSpec.describe Game do
  let(:player1) { Player.new('player 1') }
  let(:player2) { Player.new('player 2') }
  subject { Game.new(player1, player2) }

  describe 'initialize' do
    it 'will take two Player instances and assign them to @player1, @player2' do
      expect(subject.instance_variable_get(:@player1)).to eq(player1)
      expect(subject.instance_variable_get(:@player2)).to eq(player2)
    end
  end

  describe 'new_match' do
    let(:mark) { %w[X O].sample }
    before { allow(subject).to receive(:prompt).and_return(mark) }
    before { subject.new_match }

    it "will reset readable attr @status to 'continue'" do
      expect(subject.status).to eq('continue')
    end

    it 'will reset @rounds to Zero' do
      expect(subject.instance_variable_get(:@rounds)).to eq(0)
    end

    it 'will reset @board to Board.new' do
      expect(subject.instance_variable_get(:@board).board.all? { |row| row.all? { |e| e.is_a?(Integer) } }).to be true
    end

    it 'will reset @turn to @player2' do
      expect(subject.instance_variable_get(:@turn)).to eq(subject.instance_variable_get(:@player2))
    end

    it 'will assign players marks' do
      expect(subject.instance_variable_get(:@player1).mark).to eq(mark)
      expect(subject.instance_variable_get(:@player2).mark).to eq((%w[X O] - [mark]).first)
    end
  end

  describe 'play' do
  end

  describe 'play_again?' do
  end
end
