# frozen_string_literal: true

require 'logger'
require 'securerandom'

module App
  module IO
    module Loggers
      # Game Log Class
      class DefaultLogger
        attr_reader :logger

        def initialize(log_file = 'game.log')
          @logger = Logger.new(log_file)
          @logger.info("\n\n\nNew Game ID: #{SecureRandom.uuid}")
          @colors = {
            info: ->(msg) { "\e[32m#{msg}\e[0m" }, # Green
            warn: ->(msg) { "\e[33m#{msg}\e[0m" }, # Yellow
            error: ->(msg) { "\e[31m#{msg}\e[0m" }, # Red
            debug: ->(msg) { "\e[36m#{msg}\e[0m" }  # Cyan
          }
        end

        def print(msg: '', type: :info)
          puts @colors[type]&.call(msg) || msg
        end

        def clear
          puts "\033c"
        end
      end
    end
  end
end
