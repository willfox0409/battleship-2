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
    it 'defaults to nil' do
      expect(@cell.ship).to eq(nil)
    end
  end

  describe '#place_ship' do 
    it 'places a ship in a cell' do
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

  describe '#fired_upon?' do 
    it 'asks if cell has been fired_upon and defaults to false' do 
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end 
  end

  describe '#fire_upon' do 
    it 'decreases ships health when invoked, and updates fired_upon to true' do 
      @cell.place_ship(@cruiser)
      @cell.fire_upon

      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  end
end