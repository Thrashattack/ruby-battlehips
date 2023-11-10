# frozen_string_literal: true

# Ship Class
class Ship
  attr_reader :size, :cells

  def initialize(
    size: 1,
    is_vertical: [false, true].sample,
    damage: 0,
    cells: []
  )
    @size = size
    @is_vertical = is_vertical
    @damage = damage
    @cells = cells
  end

  def vertical?
    @is_vertical
  end

  def add_cell(cell)
    @cells.push(cell)
  end

  def sank?
    @size == @damage
  end

  def hit?
    return false if sank?

    @damage += 1

    true
  end

  def to_s
    string = ''

    cells.each do |cell|
      string += "#{cell}, "
    end

    string
  end
end
