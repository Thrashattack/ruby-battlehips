# frozen_string_literal: true

# Cell class
class Cell
  attr_reader :value, :coordinate_x, :coordinate_y

  def initialize(
    coordinate_x: nil,
    coordinate_y: nil,
    value: false
  )
    @x = coordinate_x
    @y = coordinate_y
    @value = value
    @has_ship = false
    @was_hitted = false
    @is_hidden = true
  end

  def print_cell_content
    return print_hidden if @is_hidden

    if @was_hitted
      print_hits
    else
      print_missed
    end
  end

  def assign(value)
    @has_ship = true
    @value = value
  end

  def hit
    @is_hidden = false
    @was_hitted = true if @has_ship
  end

  def to_s
    "(#{@x + 1}, #{@y + 1}) -> #{@value}"
  end

  private

  def print_hidden
    "\e[1;31m| \e[0;34m* "
  end

  def print_hits
    "\e[1;31m| \e[1;32m#{@value} "
  end

  def print_missed
    "\e[1;31m|   "
  end
end
