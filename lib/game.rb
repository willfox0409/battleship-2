class Game 
  attr_reader :computer_board, :player_board

  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer_cruiser = Ship.new("cruiser", 3)
    @computer_submarine = Ship.new("submarine", 2)
    @player_cruiser = Ship.new("cruiser", 3)
    @player_submarine = Ship.new("submarine", 2)
  end

  def main_menu
    
  end

  def computer_setup
    
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


end