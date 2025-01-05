class Board
    attr_reader :cells
    
    def initialize 
        @cells = {
            "A1" => Cell.new("A1"),
            "A2" => Cell.new("A2"),
            "A3" => Cell.new("A3"),
            "A4" => Cell.new("A4"),
            "B1" => Cell.new("B1"),
            "B2" => Cell.new("B2"),
            "B3" => Cell.new("B3"),
            "B4" => Cell.new("B4"),
            "C1" => Cell.new("C1"),
            "C2" => Cell.new("C2"),
            "C3" => Cell.new("C3"),
            "C4" => Cell.new("C4"),
            "D1" => Cell.new("D1"),
            "D2" => Cell.new("D2"),
            "D3" => Cell.new("D3"),
            "D4" => Cell.new("D4")
        }
    end

    def valid_coordinate?(coordinate)
        @cells.has_key?(coordinate)
    end

    def place(ship, coordinates)
        coordinates.each do |coordinate|
            @cells[coordinate].place_ship(ship)
        end
    end

    def valid_length?(ship, coordinates)
        ship.length == coordinates.count
    end

    def empty_cells?(coordinates)
        coordinates.all? do |coordinate|
            @cells[coordinate].empty?
        end
    end

    def horizontal?(coordinates) 
        same_letter = coordinates.each_cons(2).all? do |coordinate_1, coordinate_2| 
            coordinate_1[0] == coordinate_2[0]
        end

        consecutive_numbers = coordinates.each_cons(2).all? do |coordinate_1, coordinate_2|
            coordinate_1[1].to_i == coordinate_2[1].to_i + 1 
        end

    end
end