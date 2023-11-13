# frozen_string_literal: true

module App
  # Game Class
  class Game < App::IO::STDIO
    attr_reader :board, :size, :shoots, :score

    def initialize(size: 10,
                   shoots: 50,
                   debug: false)
      super(game: self)
      @size = size
      @shoots = shoots
      @debug = debug
      @score = 0
    end

    def setup
      setup_board

      setup_ships

      place_ships

      self
    end

    def play
      loop do
        break if @shoots.zero? || @ships.map(&:sank?).all?

        run_turn
      end

      is_winner = @ships.map(&:sank?).all?
      @board.reveal
      game_over(is_winner:)
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

    def run_turn
      cell = @board.at(*ask_player_input)

      if cell.hit_a_ship?
        @score += 100 / cell.value
        print_hit(cell)
      else
        print_missed(cell)
      end

      @shoots -= 1
      score_info
    end
  end
end
