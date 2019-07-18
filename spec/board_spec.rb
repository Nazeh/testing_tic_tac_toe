require_relative "../lib/board.rb"

RSpec.describe Board do
  let(:new_board){Board.new}

   describe "initializing board" do
      subject {new_board}
      it 'should not equal to' do
         expect(new_board.board).not_to be nil
      end
   end

   describe "update" do
      let(:cell){4}
      let(:mark){'X'}
      subject{new_board.update(cell, mark)}
      it{should be_eql('X')}
   end
end


