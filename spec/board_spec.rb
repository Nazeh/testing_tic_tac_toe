require_relative "../lib/board.rb"

RSpec.describe Board do
  let(:new_board){Board.new}

   describe "#initialize" do
      subject {new_board.board}
      it {should be_eql([[1, 2, 3], [4, 5, 6], [7, 8, 9]])}
   end

   describe "#update" do
      let(:mark){'X'}
      subject {new_board.board}

      context 'When mark cell 4, board:' do
         let(:cell){4}
         before { new_board.update(cell, mark) }
         it{should be_eql([[1, 2, 3], ['X', 5, 6], [7, 8, 9]])}
      end

      context 'When mark cell 9, board:' do
         let(:cell){9}
         before { new_board.update(cell, mark) }
         it{should be_eql([[1, 2, 3], [4, 5, 6], [7, 8, 'X']])}
      end

      context 'When mark cell 1, while cell 5 is marked board:' do
         let(:cell){1}
         before { new_board.update(5, 'O') }
         before { new_board.update(cell, mark) }
         it{should be_eql([['X', 2, 3], [4, 'O', 6], [7, 8, 9]])}
      end
   end
end


