# frozen_string_literal: true

require('./game')

size = ARGV[0].to_i.positive? ? ARGV[0].to_i : 10

shoots = ARGV[0].to_i.positive? ? ARGV[1].to_i : 50

debug = ARGV[2] == 'true' || false

Game.new(size:, shoots:, debug:).setup.play
