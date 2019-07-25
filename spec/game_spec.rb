# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do
  let(:player1)      { Player.new('player 1') }
  let(:player2)      { Player.new('player 2') }
  let(:first_player) { [1, 2].sample }
  subject { Game.new(player1, player2, first_player) }

  describe '#initialize' do
    it 'will take two Player instances and assign them to readable attr @player1 & @player2' do
      expect(subject.player1).to eq(player1)
      expect(subject.player2).to eq(player2)
    end
    it 'will initiate readable @status = "continue"' do
      expect(subject.status).to eq('continue')
    end
    it 'will initiate readable @board and set it to new board' do
      expect(subject.board.board).to eq(Board.new.board)
    end

    context 'when it is given 1 as first_player' do
      subject { Game.new(player1, player2, 1) }
      it 'will add_mark X to @player1' do
        expect(subject.player1.mark).to eq('X')
      end
      it 'will add_mark O to @player2' do
        expect(subject.player2.mark).to eq('O')
      end
      it 'will initiate readable attr @current_player and set it to @player1' do
        expect(subject.current_player).to eq(subject.player1)
      end
    end

    context 'when it is given 2 as first_player' do
      subject { Game.new(player1, player2, 2) }
      it 'will add_mark X to @player2' do
        expect(subject.player2.mark).to eq('X')
      end
      it 'will add_mark O to @player1' do
        expect(subject.player1.mark).to eq('O')
      end
      it 'will initiate readable attr @current_player and set it to @player2' do
        expect(subject.current_player).to eq(subject.player2)
      end
    end
  end

  # helper methods
  def row(cell)
    (cell - 1) / 3
  end

  def col(cell)
    (cell - 1) % 3
  end

  describe '#next_move' do
    let(:cell) { (1..9).to_a.sample }
    it 'will update the board at the given cell with @current_player mark' do
      subject.next_move(cell)
      expect(subject.board.board[row(cell)][col(cell)]).to eq('X')
    end

    context 'when nine moves are played, with now winners' do
      before { 9.times { |cell| subject.next_move(cell) } }
      it 'will update @status to draw' do
        expect(subject.status).to eq('draw')
      end
    end

    context 'when row is completed' do
      let(:plays) { [[1, 5, 2, 6, 3], [1, 4, 2, 5, 9, 6]].sample }
      before { plays.each { |cell| subject.next_move(cell) } }
      it 'will update @status to win' do
        expect(subject.status).to eq('win')
      end
      it 'will not switch @current_player' do
        expect(subject.current_player.mark).to eq(%w[X O][plays.length % 5])
      end
      it 'will update @current_player score' do
        expect(subject.current_player.score).to eq(1)
      end
    end

    context 'when col is completed' do
      let(:plays) { [[1, 5, 4, 6, 7], [1, 3, 2, 6, 5, 9]].sample }
      before { plays.each { |cell| subject.next_move(cell) } }
      it 'will update @status to win' do
        expect(subject.status).to eq('win')
      end
      it 'will not switch @current_player' do
        expect(subject.current_player.mark).to eq(%w[X O][plays.length % 5])
      end
      it 'will update @current_player score' do
        expect(subject.current_player.score).to eq(1)
      end
    end

    context 'when diagonal is completed' do
      let(:plays) { [[1, 4, 5, 6, 9], [1, 3, 2, 5, 6, 7]].sample }
      before { plays.each { |cell| subject.next_move(cell) } }
      it 'will update @status to win' do
        expect(subject.status).to eq('win')
      end
      it 'will not switch @current_player' do
        expect(subject.current_player.mark).to eq(%w[X O][plays.length % 5])
      end
      it 'will update @current_player score' do
        expect(subject.current_player.score).to eq(1)
      end
    end
  end
end
