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

  let(:mark) { %w[X O].sample }

  # simulate different values in mid_game
  before do
    subject.instance_variable_set(:@status, 'win')
    subject.instance_variable_set(:@rounds, 1)
    subject.instance_variable_set(:@board, 5)
    subject.instance_variable_set(:@turn, @player1)
  end

  # reset values with new_match
  before do
    allow(subject).to receive(:prompt).and_return(mark)
    subject.new_match
  end

  describe '#new_match' do
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

    it 'will assign players marks in a new match' do
      allow(subject).to receive(:prompt).and_return((%w[X O] - [mark]).first)
      subject.new_match
      expect(subject.instance_variable_get(:@player1).mark).to eq((%w[X O] - [mark]).first)
      expect(subject.instance_variable_get(:@player2).mark).to eq(mark)
    end
  end

  describe '#play' do
    let(:players) { [subject.instance_variable_get(:@player1), subject.instance_variable_get(:@player2)] }
    let(:cur_player) { players.sample }

    it 'will switch @turn to the other player' do
      subject.instance_variable_set(:@turn, cur_player)
      allow(subject).to receive(:prompt).and_return('1')
      subject.play
      expect(subject.instance_variable_get(:@turn)).to eq((players - [cur_player]).first)
      subject.play
      expect(subject.instance_variable_get(:@turn)).to eq(cur_player)
    end

    it 'will keep @status = continue in general casses' do
      board = Board.new
      board.instance_variable_set(:@board, [[mark, 2, 3], [4, mark, 6], [7, 8, 9]])
      subject.instance_variable_set(:@board, board)
      allow(subject).to receive(:prompt).and_return('7')
      subject.play
      expect(subject.instance_variable_get(:@status)).to eq('continue')
    end

    it 'will set @status to win when row is completed' do
      board = Board.new
      board.instance_variable_set(:@board, [[mark, mark, 3], [4, 5, 6], [7, 8, 9]])
      subject.instance_variable_set(:@board, board)
      allow(subject).to receive(:prompt).and_return('3')
      subject.play
      expect(subject.instance_variable_get(:@status)).to eq('win')
    end

    it 'will set @status to win when col is completed' do
      board = Board.new
      board.instance_variable_set(:@board, [[mark, 2, 3], [mark, 5, 6], [7, 8, 9]])
      subject.instance_variable_set(:@board, board)
      allow(subject).to receive(:prompt).and_return('7')
      subject.play
      expect(subject.instance_variable_get(:@status)).to eq('win')
    end

    it 'will set @status to win when diagonal is completed' do
      board = Board.new
      board.instance_variable_set(:@board, [[mark, 2, 3], [4, mark, 6], [7, 8, 9]])
      subject.instance_variable_set(:@board, board)
      allow(subject).to receive(:prompt).and_return('9')
      subject.play
      expect(subject.instance_variable_get(:@status)).to eq('win')
    end

    it 'will set @status to draw when 9 rounds are played' do
      subject.instance_variable_set(:@rounds, 8)
      allow(subject).to receive(:prompt).and_return('3')
      subject.play
      expect(subject.instance_variable_get(:@status)).to eq('draw')
    end
  end

  describe '#play_again?' do
    let(:players) { [subject.instance_variable_get(:@player1), subject.instance_variable_get(:@player2)] }
    before { subject.instance_variable_set(:@turn, players.sample) }

    it 'will not update score if the game ended with draw' do
      allow(subject).to receive(:prompt).and_return('n')
      subject.play_again?
      expect(subject.instance_variable_get(:@turn).score).to eq(0)
    end

    it 'will update score if the game ended with win' do
      subject.instance_variable_set(:@status, 'win')
      allow(subject).to receive(:prompt).and_return('n')
      subject.play_again?
      expect(subject.instance_variable_get(:@turn).score).to eq(1)
    end

    it 'will return true if user inputs Y' do
      allow(subject).to receive(:prompt).and_return('y')
      subject.play_again?
      expect(subject.play_again?).to be true
    end

    it 'will return false if user inputs N' do
      allow(subject).to receive(:prompt).and_return('n')
      subject.play_again?
      expect(subject.play_again?).to be false
    end
  end
end
