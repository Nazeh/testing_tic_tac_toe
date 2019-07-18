# frozen_string_literal: true

require_relative '../lib/player'

RSpec.describe Player do
  let(:player_name) { 'player1' }
  let(:player) { Player.new(player_name) }

  describe '#add_score' do
    subject { player.score }
    before { player.add_score}

    context 'When adding score to zero' do
      it { should be_eql(1) }
    end

    context 'When adding score to one' do
      before { player.add_score}
      it { should be_eql(2) }
    end

  end
end
