# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

RSpec.describe Game do
  # generate random player names
  def generate_name
    [*('A'..'Z'), *('0'..'9')].sample(5).join.to_s
  end

  let(:player_names) { [generate_name, generate_name] }
  subject { Game.new(Player.new(player_names[0]), Player.new(player_names[1])) }

  describe '#initialize' do
    it 'will accept two player instances and assign them to @player1, @player2' do
      expect(subject.instance_variable_get(:@player1).name).to eq(player_names[0])
      expect(subject.instance_variable_get(:@player2).name).to eq(player_names[1])
    end
  end

  let(:mark) { %w[X O].sample }

  before do
    allow(subject).to receive(:prompt).and_return(mark)
    subject.new_match
  end

  describe '#new_match' do
    context 'when called for first time' do
      it 'will initiate @status to equal "continue" ' do
        expect(subject.status).to eq('continue')
      end

      it 'will initiate @moves to Zero' do
        expect(subject.instance_variable_get(:@moves)).to eq(0)
      end

      it 'will reset @board to new Board instance' do
        expect(subject.instance_variable_get(:@board).board.all? { |row| row.all? { |e| e.is_a?(Integer) } }).to be true
      end

      it 'will reset @cur_player to @player1' do
        expect(subject.instance_variable_get(:@cur_player)).to eq(subject.instance_variable_get(:@player1))
      end

      it 'will assign players marks' do
        expect(subject.instance_variable_get(:@player1).mark).to eq(mark)
        expect(subject.instance_variable_get(:@player2).mark).to eq((%w[X O] - [mark]).first)
      end

      it 'will assign players marks in a new match' do
        allow(subject).to receive(:prompt).and_return(mark)
        subject.new_match
        expect(subject.instance_variable_get(:@player1).mark).to eq(mark)
        expect(subject.instance_variable_get(:@player2).mark).to eq((%w[X O] - [mark]).first)
      end
    end

    # simulate different values in mid_game
    before do
      subject.instance_variable_set(:@status, 'win')
      subject.instance_variable_set(:@moves, 1)
      subject.instance_variable_set(:@board, 5)
      subject.instance_variable_set(:@cur_player, @player1)
    end

    # reset values with new_match
    before do
      allow(subject).to receive(:prompt).and_return(mark)
      subject.new_match
    end

    context 'when called for after playing a match' do
      it "will reset readable attr @status to 'continue'" do
        expect(subject.status).to eq('continue')
      end

      it 'will reset @moves to Zero' do
        expect(subject.instance_variable_get(:@moves)).to eq(0)
      end

      it 'will reset @board to Board.new' do
        expect(subject.instance_variable_get(:@board).board.all? { |row| row.all? { |e| e.is_a?(Integer) } }).to be true
      end

      it 'will reset @cur_player to @player2' do
        expect(subject.instance_variable_get(:@cur_player)).to eq(subject.instance_variable_get(:@player1))
      end

      it 'will reassign players marks' do
        expect(subject.instance_variable_get(:@player1).mark).to eq(mark)
        expect(subject.instance_variable_get(:@player2).mark).to eq((%w[X O] - [mark]).first)
      end

      it 'will reassign players marks in a new match' do
        allow(subject).to receive(:prompt).and_return((%w[X O] - [mark]).first)
        subject.new_match
        expect(subject.instance_variable_get(:@player1).mark).to eq((%w[X O] - [mark]).first)
        expect(subject.instance_variable_get(:@player2).mark).to eq(mark)
      end
    end
  end

  # describe '#play' do
  #   let(:players) { [subject.instance_variable_get(:@player1), subject.instance_variable_get(:@player2)] }
  #   let(:cur_player) { players.sample }

  #   it 'will switch @turn to the other player' do
  #     subject.instance_variable_set(:@turn, cur_player)
  #     allow(subject).to receive(:prompt).and_return('1')
  #     subject.play
  #     expect(subject.instance_variable_get(:@turn)).to eq((players - [cur_player]).first)
  #     subject.play
  #     expect(subject.instance_variable_get(:@turn)).to eq(cur_player)
  #   end

  #   it 'will keep @status = continue in general casses' do
  #     board = Board.new
  #     board.instance_variable_set(:@board, [[mark, 2, 3], [4, mark, 6], [7, 8, 9]])
  #     subject.instance_variable_set(:@board, board)
  #     allow(subject).to receive(:prompt).and_return('7')
  #     subject.play
  #     expect(subject.instance_variable_get(:@status)).to eq('continue')
  #   end

  #   it 'will set @status to win when row is completed' do
  #     board = Board.new
  #     board.instance_variable_set(:@board, [[mark, mark, 3], [4, 5, 6], [7, 8, 9]])
  #     subject.instance_variable_set(:@board, board)
  #     allow(subject).to receive(:prompt).and_return('3')
  #     subject.play
  #     expect(subject.instance_variable_get(:@status)).to eq('win')
  #   end

  #   it 'will set @status to win when col is completed' do
  #     board = Board.new
  #     board.instance_variable_set(:@board, [[mark, 2, 3], [mark, 5, 6], [7, 8, 9]])
  #     subject.instance_variable_set(:@board, board)
  #     allow(subject).to receive(:prompt).and_return('7')
  #     subject.play
  #     expect(subject.instance_variable_get(:@status)).to eq('win')
  #   end

  #   it 'will set @status to win when diagonal is completed' do
  #     board = Board.new
  #     board.instance_variable_set(:@board, [[mark, 2, 3], [4, mark, 6], [7, 8, 9]])
  #     subject.instance_variable_set(:@board, board)
  #     allow(subject).to receive(:prompt).and_return('9')
  #     subject.play
  #     expect(subject.instance_variable_get(:@status)).to eq('win')
  #   end

  #   it 'will set @status to draw when 9 rounds are played' do
  #     subject.instance_variable_set(:@rounds, 8)
  #     allow(subject).to receive(:prompt).and_return('3')
  #     subject.play
  #     expect(subject.instance_variable_get(:@status)).to eq('draw')
  #   end
  # end

  # describe '#play_again?' do
  #   let(:players) { [subject.instance_variable_get(:@player1), subject.instance_variable_get(:@player2)] }
  #   before { subject.instance_variable_set(:@turn, players.sample) }

  #   it 'will not update score if the game ended with draw' do
  #     allow(subject).to receive(:prompt).and_return('n')
  #     subject.play_again?
  #     expect(subject.instance_variable_get(:@turn).score).to eq(0)
  #   end

  #   it 'will update score if the game ended with win' do
  #     subject.instance_variable_set(:@status, 'win')
  #     allow(subject).to receive(:prompt).and_return('n')
  #     subject.play_again?
  #     expect(subject.instance_variable_get(:@turn).score).to eq(1)
  #   end

  #   it 'will return true if user inputs Y' do
  #     allow(subject).to receive(:prompt).and_return('y')
  #     subject.play_again?
  #     expect(subject.play_again?).to be true
  #   end

  #   it 'will return false if user inputs N' do
  #     allow(subject).to receive(:prompt).and_return('n')
  #     subject.play_again?
  #     expect(subject.play_again?).to be false
  #   end
  # end
end
