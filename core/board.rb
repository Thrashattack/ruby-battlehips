# frozen_string_literal: true

module Core
  # Board class
  class Board
    attr_reader :board_size, :cells

    def initialize(size: 10, cells: [])
      @board_size = size
      @cells = cells
    end

    def at(coordinate_x, coordinate_y)
      @cells[coordinate_x][coordinate_y]
    end

    def to_s
      string = ''
      @board_size.times do |i|
        row = ''
        @board_size.times do |j|
          row += board_cell_content(i, j)
        end
        string += "#{row}\n"
      end

      string
    end

    def fill
      @board_size.times do |i|
        @cells[i] = []
        @board_size.times do |j|
          @cells[i][j] = Core::Cell.new(coordinate_x: i, coordinate_y: j, value: false)
        end
      end
    end

    def place(ship)
      cells = []

      (x, y) = generate_random_coordinates(ship)

      ship.size.times do |offset|
        cells << place_at(offset, x, y, ship)
      end

      cells
    end

    def reveal
      @board_size.times do |x|
        @board_size.times do |y|
          @cells[x][y].hit_a_ship? if @cells[x][y].value
        end
      end
    end

    private

    def board_cell_content(index, jindex)
      string = ''
      string += header_coordinates if index.zero? && jindex.zero?
      string += side_coordinates(index) if jindex.zero?
      string += @cells[index][jindex].print_cell_content

      string
    end

    def header_coordinates
      "     \e[36m#{(1...@board_size + 1).map do |index|
                      index >= 10 ? index.to_s : "#{index} "
                    end.join('| ')}\n"
    end

    def side_coordinates(index)
      " \e[36m#{index + 1 >= 10 ? index + 1 : "#{index + 1} "}"
    end

    def generate_random_coordinates(ship)
      loop do
        x = rand @board_size
        y = rand @board_size
        orientation = ship.vertical? ? y : x

        return [x, y] if fits?(orientation, ship.size) && !collision?(ship.size, x, y, ship.vertical?)
      end
    end

    def place_at(offset, coordinate_x, coordinate_y, ship)
      if ship.vertical?
        coordinate_y += offset
      else
        coordinate_x += offset
      end

      cell = @cells[coordinate_x][coordinate_y]

      cell.assign(ship)

      cell
    end

    def collision?(ship_size, coordinate_x, coordinate_y, is_vertical)
      ship_size.times do |offset|
        x = is_vertical ? coordinate_x : coordinate_x + offset
        y = is_vertical ? coordinate_y + offset : coordinate_y

        return true if @cells[x][y].value
      end

      false
    end

    def fits?(orientation, ship_size)
      return true if ship_size == 1

      return true if orientation + ship_size <= @board_size

      false
    end
  end
end
