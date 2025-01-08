class Game 
  attr_reader :computer_board, :player_board, :computer_cruiser, :computer_submarine, :player_cruiser, :player_submarine

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_cruiser = Ship.new("cruiser", 3)
    @computer_submarine = Ship.new("submarine", 2)
    @player_cruiser = Ship.new("cruiser", 3)
    @player_submarine = Ship.new("submarine", 2)
  end

  def computer_cruiser_setup
    cruiser_coordinates = @computer_board.cells.keys.sample(3)
    while @computer_board.valid_placement?(@computer_cruiser, cruiser_coordinates) == false
      cruiser_coordinates = @computer_board.cells.keys.sample(3)
      @computer_board.valid_placement?(@computer_cruiser, cruiser_coordinates)
    end
    @computer_board.place(@computer_cruiser, cruiser_coordinates)
  end

  def computer_submarine_setup
    submarine_coordinates = @computer_board.cells.keys.sample(2)
    while @computer_board.valid_placement?(@computer_submarine, submarine_coordinates) == false
      submarine_coordinates = @computer_board.cells.keys.sample(2)
      @computer_board.valid_placement?(@computer_submarine, submarine_coordinates)
    end
    @computer_board.place(@computer_submarine, submarine_coordinates)
  end

  def player_cruiser_setup
    puts ""
    puts "I have laid out my ships on the grid. \n" + "You now need to lay out your two ships. \n" + "The Cruiser is three units long, and the Submarine is two units long."
    puts ""
    puts @player_board.render(true)
    puts ""
    puts "Enter the squares for the Cruiser (3 spaces):"
    puts ""
    cruiser_coordinates = gets.chomp.upcase
    puts ""
    while @player_board.valid_placement?(@player_cruiser, cruiser_coordinates.split(" ")) == false 
      puts "Those are invalid coordinates. Please try again:"
      puts ""
      cruiser_coordinates = gets.chomp.upcase 
      @player_board.valid_placement?(@player_cruiser, cruiser_coordinates.split(" "))
    end
    @player_board.place(@player_cruiser, cruiser_coordinates.split(" "))
  end

  def player_submarine_setup
    puts ""
    puts @player_board.render(true)
    puts ""
    puts "Enter the squares for the Submarine (2 spaces):"
    puts ""
    submarine_coordinates = gets.chomp.upcase
    puts ""
    while @player_board.valid_placement?(@player_submarine, submarine_coordinates.split(" ")) == false
      puts "Those are invalid coordinates. Please try again:"
      puts ""
      submarine_coordinates = gets.chomp.upcase 
      puts ""
      @player_board.valid_placement?(@player_submarine, submarine_coordinates.split(" "))
    end
    @player_board.place(@player_submarine, submarine_coordinates.split(" "))
    puts @player_board.render(true)
  end

  def display_boards
    puts ""
    puts "=" * 13 + "COMPUTER BOARD" + "=" * 13
    puts ""
    puts @computer_board.render
    puts ""
    puts "=" * 13 + "PLAYER BOARD" + "=" * 13
    puts ""
    puts @player_board.render(true)
  end

  def player_turn
    puts ""
    display_boards
    puts ""
    puts "Enter the coordinate for your shot:"
    puts ""
    player_shot = gets.chomp.upcase
    puts ""
  
    until @computer_board.valid_coordinate?(player_shot) && !@computer_board.cells[player_shot].fired_upon?
      if @computer_board.valid_coordinate?(player_shot) == false
        puts "Invalid coordinate. Please try again:"
        puts ""
      elsif @computer_board.cells[player_shot].fired_upon?
        puts "You've already fired at this cell. Choose another coordinate:"
        puts ""
      end
      player_shot = gets.chomp.upcase
      puts ""
    end
  
    @computer_board.cells[player_shot].fire_upon
  
    if @computer_board.cells[player_shot].render == "H"
      puts "Your shot on #{player_shot} was a hit!"
      puts ""
    elsif @computer_board.cells[player_shot].render == "X"
      puts "You sunk my #{@computer_board.cells[player_shot].ship.name}!"
      puts ""
    else
      puts "Your shot on #{player_shot} was a miss."
      puts ""
    end
  end

  def computer_turn
    computer_shot = @player_board.cells.keys.sample
  
    while @player_board.cells[computer_shot].fired_upon?
      computer_shot = @player_board.cells.keys.sample
    end
  
    @player_board.cells[computer_shot].fire_upon
  
    if @player_board.cells[computer_shot].render == "H"
      puts "My shot on #{computer_shot} was a hit!"
      puts ""
    elsif @player_board.cells[computer_shot].render == "X"
      puts "I sunk your #{@player_board.cells[computer_shot].ship.name}!"
      puts ""
    else
      puts "My shot on #{computer_shot} was a miss."
      puts ""
    end
  end
  
  def game_over
    if @player_cruiser.sunk? && @player_submarine.sunk?
      puts "I won!"
      puts ""
      return true
    elsif @computer_cruiser.sunk? && @computer_submarine.sunk?
      puts "You won!"
      puts ""
      return true
    else
      return false
    end
  end
end