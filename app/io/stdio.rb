# frozen_string_literal: true

module App
  module IO
    # STDIN Class
    class STDIO
      def initialize(game:)
        @game = game
        @log = App::IO::Loggers::DefaultLogger.new
      end

      def score_info
        @log.print(msg: "Remaining shoots: #{@game.shoots}", type: :warn)
        @log.print(msg: "Score: #{@game.score}\n\n", type: :info)
        @log.logger.warn("Remaining shoots: #{@game.shoots}")
        @log.logger.info("Score: #{@game.score}")
      end

      def log_cells(cells)
        @log.logger.debug(cells.map(&:to_s))
      end

      def ask_player_input
        @log.print(msg: 'Guess a Coordinate!', type: nil)
        @log.print(msg: "Format: x,y\n\n", type: :debug)
        @log.print(msg: @game.board)

        validate_input!
      rescue App::IO::Errors::InvalidInputError => e
        @log.logger.error(e.msg(@game.size))
        @log.clear
        @log.print(msg: e.msg(@game.size), type: :error)
        ask_player_input
      end

      def validate_input!
        player_input = $stdin.gets.chomp.to_s.split(',')
        x = player_input[0].to_i - 1
        y = player_input[1].to_i - 1

        raise App::IO::Errors::InvalidInputError unless (x >= 0 && x < @game.size) && (y >= 0 && y < @game.size)

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

      def game_over(is_winner: false)
        if is_winner
          @log.print(msg: 'Congrats! You win! :D', type: :info)
          @log.logger.info('Winner')
        else
          @log.print(msg: 'You lose! More lucky next time! :(', type: :error)
          @log.logger.fatal('Loser')
        end

        @log.print(msg: @game.board)
      end
    end
  end
end
