# frozen_string_literal: true

require('./app/game')

require('./core/board')
require('./core/ship')
require('./core/cell')

require('./utils/game_log')
require('./utils/errors')
require('./utils/parse_args')

(size, shoots, debug) = Utils::Parse.args

App::Game.new(size:, shoots:, debug:).setup.play
