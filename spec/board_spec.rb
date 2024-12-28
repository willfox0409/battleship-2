require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do 
    before(:each) do 
        @board = Board.new
    end

    describe '#initialize' do 
        it 'exists' do 
            expect(@board).to be_a(Board) 
        end

        it 'holds 16 cell objects in a hash' do 
            expect(@board.cells).to be_a(Hash)
            expect(@board.cells.count).to eq(16)
            expect(@board.cells["A1"]).to be_a(Cell)
            expect(@board.cells["B2"]).to be_a(Cell)
            expect(@board.cells["C3"]).to be_a(Cell)
            expect(@board.cells["D4"]).to be_a(Cell)
        end
    end
end