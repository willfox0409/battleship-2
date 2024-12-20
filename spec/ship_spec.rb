require './lib/ship'

RSpec.describe Ship do 
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end
    
    describe '#initialize' do
        it 'exists' do
            expect(@cruiser).to be_a(Ship)
        end

        it 'has a name' do
            expect(@cruiser.name).to eq("Cruiser")
        end

        it 'has a length' do
            expect(@cruiser.length).to eq(3)
        end

        it 'has a health level' do
            expect(@cruiser.health).to eq(3)
        end
    end

    describe '#hit' do 
        it 'records a hit on a ship and decreases health by one' do 
            expect(@cruiser.health).to eq(3)
            expect(@cruiser.sunk?).to eq(false)

            @cruiser.hit
            expect(@cruiser.health).to eq(2)
        end
    end

    describe '#sunk?' do 
        it 'asks if a ship is sunk and defaults to false' do 
            expect(@cruiser.health).to eq(3)
            expect(@cruiser.sunk?).to eq(false)
        end

        it 'returns true if health is zero' do 
            expect(@cruiser.health).to eq(3)
            expect(@cruiser.sunk?).to eq(false)

            @cruiser.hit
            expect(@cruiser.health).to eq(2)

            @cruiser.hit
            expect(@cruiser.health).to eq(1)

            @cruiser.hit
            expect(@cruiser.sunk?).to eq(true)
        end
    end 
end