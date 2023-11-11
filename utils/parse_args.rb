# frozen_string_literal: true

module Utils
  # Parse class
  class Parse
    def self.args
      size = ARGV[0].to_i.positive? ? ARGV[0].to_i : 10

      shoots = ARGV[0].to_i.positive? ? ARGV[1].to_i : 50

      debug = ARGV[2] == 'true' || false

      [size, shoots, debug]
    end
  end
end
