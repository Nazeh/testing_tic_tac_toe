# frozen_string_literal: true

require_relative '../lib/ui'
require_relative '../lib/player'
require_relative '../lib/game'

RSpec.describe Ui do
  before { allow($stdout).to receive(:write) } # Supress the outputs

  describe '#prompt_name' do
    player_number = 'Player 1'

    it 'will prompt the player for their name' do
      expect { subject.prompt_name(player_number) }.to output(
        /#{player_number}: what's your name?.+default: Player 1/
      ).to_stdout
    end

    context 'when no input given' do
      it 'will return the given player_number' do
        allow(subject).to receive(:gets).and_return('')
        expect(subject.prompt_name(player_number)).to eq(player_number)
      end
    end

    context 'when a name shorter than 8 character is given' do
      it 'will return the given input' do
        name = [*('A'..'Z'), *('a'..'z'), *('0'..'9')].sample(5).join.to_s
        allow(subject).to receive(:gets).and_return(name)
        expect(subject.prompt_name(player_number)).to eq(name)
      end
    end
    context 'when a name longer than 8 character is given' do
      it 'will return the first 8 characters in the given input' do
        name = [*('A'..'Z'), *('a'..'z'), *('0'..'9')].sample(10).join.to_s
        allow(subject).to receive(:gets).and_return(name)
        expect(subject.prompt_name(player_number)).to eq(name[0...8])
      end
    end
  end

  describe '#prompt_first_player' do
    player1 = Player.new('Player 1')
    player2 = Player.new('Player 2')

    it 'will ask players to chose who plays first with X mark' do
      expect { subject.prompt_first_player(player1, player2) }.to output(
        %r{Who plays first 1:Player 1, or 2:Player 2\? \(1/2\)}
      ).to_stdout
    end

    context 'when given 2' do
      it 'will return Integer 2' do
        allow(subject).to receive(:gets).and_return('2')
        expect(subject.prompt_first_player(player1, player2)).to eq(2)
      end
    end

    context 'when given 1 or no input' do
      it 'will return Integer 1 or zero' do
        input = ['1', ''].sample
        allow(subject).to receive(:gets).and_return(input)
        expect(subject.prompt_first_player(player1, player2)).to eq(input.to_i)
      end
    end

    context 'when given Invalid input' do
      it 'will ask for input again until given proper input' do
        allow(subject).to receive(:gets).and_return('5')
        allow(subject).to receive(:gets).and_return('l')
        allow(subject).to receive(:gets).and_return('1')
        expect(subject.prompt_first_player(player1, player2)).to eq(1)
      end
    end
  end

  describe '#prompt_cell' do
    player1 = Player.new('Player 1')
    player2 = Player.new('Player 2')
    game = Game.new(player1, player2)

    it 'will ask current player to chose a cell to mark' do
      allow(subject).to receive(:gets).and_return('1')
      expect { subject.prompt_cell(game) }.to output(
        /#{game.current_player.name}.+\'s turn! choose a cell to mark!/
      ).to_stdout
    end

    context 'when given an empty cell number' do
      it 'will return Integer of cell number' do
        cell = (1..9).to_a.sample
        allow(subject).to receive(:gets).and_return(cell.to_s)
        expect(subject.prompt_cell(game)).to eq(cell)
      end
    end

    context 'when given Invalid cell number' do
      it 'will ask for input again until given proper cell number' do
        allow(subject).to receive(:gets).and_return('55')
        allow(subject).to receive(:gets).and_return('l')
        allow(subject).to receive(:gets).and_return('1')
        expect(subject.prompt_cell(game)).to eq(1)
      end
    end

    context 'when given a marked cell number' do
      before { game.next_move(5) }
      it 'will ask for input again until given an empty cell number' do
        allow(subject).to receive(:gets).and_return('5')
        allow(subject).to receive(:gets).and_return('2')
        expect(subject.prompt_cell(game)).to eq(2)
      end
    end
  end

  describe '#play_again?' do
    player1 = Player.new('Player 1')
    player2 = Player.new('Player 2')
    game = Game.new(player1, player2)

    it 'will ask players whether they want to play again?' do
      allow(subject).to receive(:gets).and_return('y')
      expect { subject.play_again?(game) }.to output(
        %r{Would you like to play again\?.+(y\/n)}
      ).to_stdout
    end

    context 'when given "n" or "N"' do
      it 'will return false' do
        answer = %w[n N].sample
        allow(subject).to receive(:gets).and_return(answer)
        expect(subject.play_again?(game)).to be false
      end
    end

    context 'when given "y" or "Y" or empty answer' do
      it 'will return true' do
        answer = ['y', 'Y', ''].sample
        allow(subject).to receive(:gets).and_return(answer)
        expect(subject.play_again?(game)).to be true
      end
    end

    context 'when given an invalid input' do
      before { game.next_move(5) }
      it 'will ask for input again until given an empty cell number' do
        allow(subject).to receive(:gets).and_return('5')
        allow(subject).to receive(:gets).and_return('g')
        allow(subject).to receive(:gets).and_return('')
        expect(subject.play_again?(game)).to be true
      end
    end
  end

  describe '#thanks?' do
    it 'will output a thanks message' do
      allow(subject).to receive(:gets).and_return('y')
      expect { subject.thanks }.to output(
        /Thanks for playing Tic Tac Toe/
      ).to_stdout
    end
    it 'will output author name message' do
      allow(subject).to receive(:gets).and_return('y')
      expect { subject.thanks }.to output(
        /Authors' Github: Nazeh/
      ).to_stdout
    end
  end
end
