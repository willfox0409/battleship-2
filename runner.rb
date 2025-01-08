require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

puts "Welcome to BATTLESHIP \n"
puts ""
puts "Enter p to play. Enter q to quit. \n>"

player_input = gets.chomp.downcase

case player_input
when "p"
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
when "q"
    puts ""
    puts "Please return again when you wish to play."
    puts ""
    puts "Goodbye for now!"
    puts ""
    exit
else
    puts "Incorrect entry, please restart the game."
end