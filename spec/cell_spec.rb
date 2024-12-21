require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each)do
    @cruiser = Ship.new("Cruiser", 3)
    @cell = Cell.new("B4")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell).to be_a(Cell)
    end

    it 'has a coordinate' do
      expect(@cell.coordinate).to eq("B4")
    end
  end
  
  describe '#ship' do
    it 'has defaults to nil' do
      expect(@cell.ship).to eq(nil)
    end

    it 'reads ship object after place_ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
    end
  end

  describe '#empty?' do
    it 'defaults to true' do
      expect(@cell.empty?).to eq(true)
    end

    it 'changes to false after place_ship' do
      @cell.place_ship(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end
end