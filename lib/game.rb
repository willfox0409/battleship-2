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

  def main_menu
    puts "Welcome to BATTLESHIP \n" + "Enter p to play. Enter q to quit. \n" + ">"
    user_input = gets.downcase.chomp
    if user_input == "p"
      computer_cruiser_setup
      computer_submarine_setup
    elsif user_input == "q"
      puts "Please return again when you wish to play. \n" + "Goodbye for now!"
      exits
    else
      puts "Incorrect entry, please try again. \n" + ">"
      user_input
    end
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
    puts "I have laid out my ships on the grid. \n" + "You now need to lay out your two ships. \n" + "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    
    cruiser_coordinates = gets.chomp.upcase
    while @player_board.valid_placement?(@player_cruiser, cruiser_coordinates.split(" ")) == false
      puts "Those are invalid coordinates. Please try again:"
      cruiser_coordinates = gets.chomp.upcase #just cruiser_coordinates work?
      @player_board.valid_placement?(cruiser_coordinates.split(" "))
    end
    @player_board.place(@player_cruiser, cruiser_coordinates.split(" "))
  end

  def player_submarine_setup
    puts @player_board.render(true)
    puts "Enter the squares for the Submarine (3 spaces):"
    
    submarine_coordinates = gets.chomp.upcase
    while @player_board.valid_placement?(@player_submarine, submarine_coordinates.split(" ")) == false
      puts "Those are invalid coordinates. Please try again:"
      submarine_coordinates = gets.chomp.upcase 
      @player_board.valid_placement?(submarine_coordinates.split(" "))
    end
    @player_board.place(@player_submarine, submarine_coordinates.split(" "))
    puts @player_board.render(true)
  end

  def display_boards
    puts "=" * 13 + "COMPUTER BOARD" + "=" * 13
    puts @computer_board.render
    puts "=" * 13 + "PLAYER BOARD" + "=" * 13
    puts @player_board.render(true)
  end

  def player_turn
    display_boards
    puts "Enter the coordinate for your shot:"
    player_shot = gets.chomp.upcase
  
    while @computer_board.valid_coordinate?(player_shot) == false || @computer_board.cells[player_shot].fired_upon?
      if @computer_board.valid_coordinate?(player_shot) == false
        puts "Invalid coordinate. Please try again:"
      elsif @computer_board.cells[player_shot].fired_upon?
        puts "You've already fired at this cell. Choose another coordinate:"
      end
      player_shot = gets.chomp.upcase
    end
  
    @computer_board.cells[player_shot].fire_upon
  
    if @computer_board.cells[player_shot].render == "H"
      puts "Your shot on #{player_shot} was a hit!"
    elsif @computer_board.cells[player_shot].render == "X"
      puts "You sunk my #{@computer_board.cells[player_shot].ship.name}!"
    else
      puts "Your shot on #{player_shot} was a miss."
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
    elsif @player_board.cells[computer_shot].render == "X"
      puts "I sunk your #{@player_board.cells[computer_shot].ship.name}!"
    else
      puts "My shot on #{computer_shot} was a miss."
    end
  end
  
  def game_over
    if @player_cruiser.sunk? && @player_submarine.sunk?
      puts "I won!"
      return true
    elsif @computer_cruiser.sunk? && @computer_submarine.sunk?
      puts "You won!"
      return true
    else
      return false
    end
  end
end