# frozen_string_literal: true

module App
  # Game Class
  class Game < App::IO::STDIO
    attr_reader :board, :size, :shoots

    def initialize(size: 10,
                   shoots: 50,
                   debug: false)
      super(game: self)
      @size = size
      @shoots = shoots
      @debug = debug
    end

    def setup
      setup_board

      setup_ships

      place_ships

      self
    end

    def play
      loop do
        break if no_more_shoots? || all_ships_sank?

        run_turn
      end

      winner = all_ships_sank?
      @board.reveal
      game_over(winner:)
    end

    private

    def setup_board
      @board = Core::Board.new(size: @size)
      @board.fill

      @board
    end

    def setup_ships
      @ships = []
      ship_amount = (@size / 2).to_i + ((@size / 2) / 2).to_i
      ship_max_size = (@size / 2).to_i

      ship_amount.times do |i|
        i -= ship_max_size if i + 1 > ship_max_size
        @ships.push(Core::Ship.new(size: i + 1))
      end
    end

    def place_ships
      @ships.each do |ship|
        cells = @board.place(ship)

        log_cells(cells) if @debug
      end

      @ships
    end

    def no_more_shoots?
      !@shoots.positive?
    end

    def all_ships_sank?
      @ships.map(&:sank?).all?
    end

    def run_turn
      cell = @board.at(*ask_player_input)

      if cell.hit_a_ship?
        print_hit(cell)
      else
        print_missed(cell)
      end

      @shoots -= 1
      shoots_info
    end
  end
end
