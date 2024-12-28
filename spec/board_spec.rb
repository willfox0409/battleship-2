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
    end
end