# frozen_string_literal: true

require('./core/board')
require('./core/ship')
require('./core/cell')

require('./app/io/parsers/cmd_parser')
require('./app/io/loggers/default_logger')
require('./app/io/errors/invalid_input_error')
require('./app/io/stdio')

require('./app/game')

(size, shoots, debug) = App::IO::Parsers::CmdParser.args

App::Game.new(size:, shoots:, debug:).setup.play
