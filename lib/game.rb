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
      cruiser_coordinates
      @computer_board.valid_placement?(@computer_cruiser, cruiser_coordinates)
    end
    @computer_board.place(@computer_cruiser, cruiser_coordinates)
  end

  def computer_submarine_setup
    submarine_coordinates = @computer_board.cells.keys.sample(2)
    while @computer_board.valid_placement?(@computer_submarine, submarine_coordinates) == false
      submarine_coordinates
      @computer_board.valid_placement?(@computer_submarine, submarine_coordinates)
    end
    @computer_board.place(@computer_submarine, submarine_coordinates)
  end

  def player_cruiser_setup
    puts "I have laid out my ships on the grid. \n" + "You now need to lay out your two ships. \n" + "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render(true)
    puts "Enter the squares for the Cruiser (3 spaces):"
    
    cruiser_coordinates = gets.chomp
    while @player_board.valid_placement?(@player_cruiser, cruiser_coordinates.split(" ")) == false
      puts "Those are invalid coordinates. Please try again:"
      cruiser_coordinates = gets.chomp #just cruiser_coordinates work?
      @player_board.valid_placement?(cruiser_coordinates.split(" "))
    end
    @player_board.place(@player_cruiser, cruiser_coordinates.split(" "))
  end

  def player_submarine_setup
    puts @player_board.render(true)
    puts "Enter the squares for the Submarine (3 spaces):"
    
    submarine_coordinates = gets.chomp
    while @player_board.valid_placement?(@player_submarine, submarine_coordinates.split(" ")) == false
      puts "Those are invalid coordinates. Please try again:"
      submarine_coordinates = gets.chomp 
      @player_board.valid_placement?(submarine_coordinates.split(" "))
    end
    @player_board.place(@player_submarine, submarine_coordinates.split(" "))
    puts @player_board.render(true)
  end
end