# frozen_string_literal: true

module App
  module IO
    module Parsers
      # Parse class
      class CmdParser
        def self.args
          size = ARGV[0].to_i.positive? ? ARGV[0].to_i : 10

          shoots = ARGV[0].to_i.positive? ? ARGV[1].to_i : 50

          debug = ARGV[2] == 'true' || false

          [size, shoots, debug]
        end
      end
    end
  end
end
