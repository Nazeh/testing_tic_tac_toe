# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'

RSpec.describe Game do
  let(:player1) { Player.new('player 1') }
  let(:player2) { Player.new('player 2') }
  subject { Game.new(player1, player2) }

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
  end

  describe '#set_first_player' do
    context 'when it is given 1' do
      before {subject.set_first_player(1)}
      it ' will add_mark X to @player1' do
        expect(subject.player1.mark).to eq('X')
      end
      it ' will add_mark O to @player2' do
        expect(subject.player2.mark).to eq('O')
      end
      it ' will initiate readable attr @current_player and set it to @player1' do
        expect(subject.current_player).to eq(subject.player1)
      end
    end
    context 'when it is given 2' do
      before {subject.set_first_player(1)}
      it ' will add_mark X to @player2' do
        expect(subject.player1.mark).to eq('X')
      end
      it ' will add_mark O to @player1' do
        expect(subject.player2.mark).to eq('O')
      end
      it ' will initiate readable attr @current_player and set it to @player2' do
        expect(subject.current_player).to eq(subject.player1)
      end
    end
  end
end
