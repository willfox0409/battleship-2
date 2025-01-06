require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do 
    before(:each) do 
        @board = Board.new
        @cruiser = Ship.new("Cruiser", 3)
        @submarine = Ship.new("Submarine", 2)
        @cell_1 = @board.cells["A1"]
        @cell_2 = @board.cells["A2"]
        @cell_3 = @board.cells["A3"]
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

    describe '#place' do 
        it 'tracks which cells the board is placed on' do 
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@cell_1.ship).to eq(@cruiser)
            expect(@cell_2.ship).to eq(@cruiser)
            expect(@cell_3.ship).to eq(@cruiser)

            expect(@cell_1.ship == @cell_2.ship).to eq(true)
        end
    end

    describe '#valid_length?' do 
        it 'determines if a specific ship has been placed correctly on the board based on length' do 
            expect(@board.valid_length?(@cruiser, ["A1", "A2"])).to eq(false)
            expect(@board.valid_length?(@submarine, ["A2", "A3", "A4"])).to eq(false)
        end
    end

    describe '#empty_cells?' do 
        it 'returns false if cells are occupied and true for empty cells' do 
            expect(@board.empty_cells?(["A1", "A2", "A3"])).to eq(true)

            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@board.empty_cells?(["A1", "A2", "A3"])).to eq(false)
        end
    end

    describe '#horizontal?' do 
        it 'verifies a consecutive horizontal placement' do 
            expect(@board.horizontal?(["A1", "B1", "A2"])).to eq(false)
            expect(@board.horizontal?(["A1", "A2", "A3"])).to eq(true)
        end
    end

    describe '#vertical?' do 
        it 'verifies a consecutive vertical placement' do 
            expect(@board.vertical?(["A1", "B1", "A2"])).to eq(false)
            expect(@board.vertical?(["A1", "B1", "C1"])).to eq(true)
        end
    end

    describe '#valid_placement?' do 
        it 'returns false if a ship has been placed horizontally' do 
            @board.place(@cruiser, ["A1", "B2", "C3"])

            expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
        end

        it 'returns false if ships are overlapping' do 
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
        end
    end

    describe '#render' do
        it 'displays the board to the user and ship placement if argument is provided' do
            @board.place(@cruiser, ["A1", "A2", "A3"])

            expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
            expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'displays a hit on the board' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            @board.cells["A1"].fire_upon

            expect(@board.render).to eq("  1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n")
            expect(@board.render(true)).to eq("  1 2 3 4 \nA H S S . \nB . . . . \nC . . . . \nD . . . . \n")
        end

        it 'displays a miss on the board' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            @board.cells["C2"].fire_upon

            expect(@board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . M . . \nD . . . . \n")
            expect(@board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . M . . \nD . . . . \n")
        end

        it 'displays that a ship has sunk' do
            @board.place(@cruiser, ["A1", "A2", "A3"])
            @board.cells["A1"].fire_upon
            @board.cells["A2"].fire_upon
            @board.cells["A3"].fire_upon
            
            expect(@board.render).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
            expect(@board.render(true)).to eq("  1 2 3 4 \nA X X X . \nB . . . . \nC . . . . \nD . . . . \n")
        end
    end
end