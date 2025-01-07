require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'

RSpec.describe Game do
  before(:each) do
    @game = Game.new
  end

  describe '#initialize' do
    it 'is a game' do
      expect(@game).to be_a Game
      expect(@game.computer_board).to be_a Board
      expect(@game.computer_cruiser).to be_a Ship
      expect(@game.computer_submarine).to be_a Ship
      expect(@game.player_board).to be_a Board
      expect(@game.player_cruiser).to be_a Ship
      expect(@game.player_submarine).to be_a Ship
    end
  end
end

