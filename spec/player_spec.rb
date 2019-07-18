# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  let(:player_name) { 'player1' }
  let(:player) { Player.new(player_name) }

  describe '#initialize' do
    it '@name = player_name' do
      expect(player.name).to eql(player_name)
    end
    it '@score = 0' do
      expect(player.score).to eql(0)
    end
  end

  describe '#add_mark' do
    context 'adding mark : "X"' do
      before { player.add_mark('X') }
      it '@mark = "X" ' do
        expect(player.mark).to eql('X')
      end
      it '@color = "31" ' do
        expect(player.color).to eql('31')
      end
    end

    context 'adding mark : "O"' do
      before { player.add_mark('O') }
      it '@mark = "X" ' do
        expect(player.mark).to eql('O')
      end
      it '@color = "32" ' do
        expect(player.color).to eql('32')
      end
    end
  end

  describe '#add_score' do
    subject { player.score }
    before { player.add_score }

    context 'When adding score to zero' do
      it { should be_eql(1) }
    end

    context 'When adding score to one' do
      before { player.add_score }
      it { should be_eql(2) }
    end
  end
end
