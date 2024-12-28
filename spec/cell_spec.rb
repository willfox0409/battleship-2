require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  before(:each)do
    @cruiser = Ship.new("Cruiser", 3)
    @cell_1 = Cell.new("B4")
    @cell_2 = Cell.new("C3")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@cell_1).to be_a(Cell)
    end

    it 'has a coordinate' do
      expect(@cell_1.coordinate).to eq("B4")
    end
  end
  
  describe '#ship' do
    it 'defaults to nil' do
      expect(@cell_1.ship).to eq(nil)
    end
  end

  describe '#place_ship' do 
    it 'places a ship in a cell' do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.ship).to eq(@cruiser)
    end
  end

  describe '#empty?' do
    it 'defaults to true' do
      expect(@cell_1.empty?).to eq(true)
    end

    it 'changes to false after place_ship' do
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.empty?).to eq(false)
    end
  end

  describe '#fired_upon?' do 
    it 'asks if cell has been fired_upon and defaults to false' do 
      @cell_1.place_ship(@cruiser)
      expect(@cell_1.fired_upon?).to eq(false)
    end 
  end

  describe '#fire_upon' do 
    it 'decreases ships health when invoked, and updates fired_upon to true' do 
      @cell_1.place_ship(@cruiser)
      @cell_1.fire_upon

      expect(@cell_1.ship.health).to eq(2)
      expect(@cell_1.fired_upon?).to eq(true)
    end
  end

  describe '#render' do
    it 'renders "." as default string repsentation of cells not yet fired upon' do
      expect(@cell_1.render).to eq(".")

      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render).to eq(".")
    end

    it 'Empty cell switches to "M" once being fired upon' do
      @cell_1.fire_upon
      expect(@cell_1.render).to eq("M")
    end


    it 'Accepts optional boolean arguement, returning "S" for cells with ships yet to be fired upon' do
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render(true)).to eq("S")
    end

    it 'Cell with ship returns "H" once being fired upon' do
      @cell_2.place_ship(@cruiser)
      @cell_2.fire_upon
      expect(@cruiser.sunk?).to eq(false)
      expect(@cell_2.render).to eq("H")
    end

    it 'fired upon returns “X” only when ship is sunk' do
      @cell_2.place_ship(@cruiser)
      expect(@cell_2.render(true)).to eq("S")
      @cell_2.fire_upon

      expect(@cell_2.render).to eq("H")
      expect(@cruiser.sunk?).to eq(false)

      @cruiser.hit
      @cruiser.hit

      expect(@cruiser.sunk?).to eq(true)
      expect(@cell_2.render).to eq("X")
    end
  end
end