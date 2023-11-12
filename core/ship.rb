# frozen_string_literal: true

module Core
  # Ship Class
  class Ship
    attr_reader :size, :cells

    def initialize(
      size: 1,
      is_vertical: [false, true].sample,
      damage: 0
    )
      @size = size
      @is_vertical = is_vertical
      @damage = damage
    end

    def vertical?
      @is_vertical
    end

    def sank?
      @damage == @size
    end

    def hit?
      return false if sank?

      @damage += 1

      true
    end
  end
end
