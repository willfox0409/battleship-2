require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

puts "Welcome to BATTLESHIP \n" + "Enter p to play. Enter q to quit."
player_input = gets.chomp
if player_input == "p"
    game = Game.new
    game.computer_cruiser_setup
    game.computer_submarine_setup
    game.player_cruiser_setup
    game.player_submarine_setup

    game.display_boards
    
    while game.game_over == false
        game.player_turn
        game.computer_turn
    end
end