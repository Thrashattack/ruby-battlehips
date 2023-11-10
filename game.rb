# frozen_string_literal: true

require('./board')
require('./ship')
require('./game_log')
require('./errors')

# Game Class
class Game
  def initialize(size: 10,
                 shoots: 50,
                 ships: [Ship.new(size: 1), Ship.new(size: 1), Ship.new(size: 2),
                         Ship.new(size: 2), Ship.new(size: 3),
                         Ship.new(size: 4), Ship.new(size: 5)],
                 debug: false,
                 log: GameLog.new)
    @size = size
    @shoots = shoots
    @ships = ships
    @debug = debug
    @log = log
    @board = Board.new(size:)
  end

  def setup
    @board.fill

    @ships.each do |ship|
      @board.place(ship)

      @log.logger.debug(ship.to_s) if @debug
    end

    self
  end

  def play
    loop do
      break if no_more_shoots? || all_ships_sank?

      run_turn
    end

    game_over
  end

  private

  def no_more_shoots?
    !@shoots.positive?
  end

  def all_ships_sank?
    @ships.map(&:sank?).all?
  end

  def run_turn
    decrease_shoots

    cell = @board.at(*ask_player_input)
    cell.hit

    @ships.map do |ship|
      next unless ship.cells.include?(cell) && ship.hit?

      return print_hit cell
    end

    print_missed cell
  end

  def decrease_shoots
    @shoots -= 1
    @log.print(msg: "Remaining shoots: #{@shoots}\n\n", type: :warn)
    @log.logger.warn("Remaining shoots: #{@shoots}")
  end

  def ask_player_input
    @log.print(msg: 'Guess a Coordinate!', type: nil)
    @log.print(msg: "Format: x,y\n\n", type: :debug)
    @log.print(msg: @board)

    player_input = $stdin.gets.chomp.to_s

    validate!(player_input)
  rescue InvalidInputError => e
    @log.logger.error(e.msg(@size))
    @log.clear
    @log.print(msg: e.msg(@size), type: :error)
    ask_player_input
  end

  def validate!(player_input)
    player_input = player_input.split(',')
    x = player_input[0].to_i - 1
    y = player_input[1].to_i - 1

    raise InvalidInputError unless (x >= 0 && x < @size) && (y >= 0 && y < @size)

    [x, y]
  end

  def print_hit(cell)
    @log.clear
    @log.logger.info("Hit Ship at #{cell}")
    @log.print(msg: ['Nice aiming!', 'Well Done!', 'Amazing shot!'].sample, type: :info)
  end

  def print_missed(cell)
    @log.clear
    @log.logger.info("Shoot missed at #{cell}")
    @log.print(msg: 'You missed!', type: :error)
  end

  def game_over
    @board.reveal
    @log.print(msg: @board)

    if all_ships_sank?
      @log.print(msg: 'Congrats! You win! :D', type: :info)
      @log.logger.info('Winner')
    else
      @log.print(msg: 'You lose! More lucky next time! :(', type: :error)
      @log.logger.fatal('Loser')
    end
  end
end
