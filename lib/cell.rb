class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false 
  end

  def empty?
    if @ship != nil
      @empty = false
    end
    @empty
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !empty?
      @ship.hit
      @fired_upon = true 
    else
      @fired_upon = true 
    end
  end

  def render(show_ships = false)
    if fired_upon? == true && empty? == false && @ship.sunk? == true
      "X"
    elsif fired_upon? == true && empty? == false && @ship.sunk? == false
      "H"
    elsif fired_upon? == true && empty? == true
      "M"
    elsif show_ships == true && fired_upon? == false && empty? == false
      "S"
    else
      "."
    end
  end
end