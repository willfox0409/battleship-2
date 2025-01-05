require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do 
    before(:each) do 
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
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

    describe '#valid_coordinate?' do 
        it 'checks whether a coordinate is valid or not' do 
            expect(@board.valid_coordinate?("A1")).to eq(true)
            expect(@board.valid_coordinate?("D4")).to eq(true)
            expect(@board.valid_coordinate?("A5")).to eq(false)
            expect(@board.valid_coordinate?("E1")).to eq(false)
            expect(@board.valid_coordinate?("A22")).to eq(false)  
        end
    end

    describe '#valid_length?' do 
        it 'determines if a specific ship has been placed correctly on the board based on length' do 
            expect(@board.valid_length?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_length?(@submarine, ["A2", "A3", "A4"])).to eq(false)
        end
    end
end