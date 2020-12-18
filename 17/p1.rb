#!/usr/bin/env ruby
# frozen_string_literal: true

INACTIVE = '.'
ACTIVE = '#'
DIRS = [-1, 0, 1]

curr = {}

$stdin.each_line
  .map(&:chomp)
  .map.with_index do |line, y|
    line.split('').map.with_index { |c, x| curr[[x, y, 0]] = c }
end

6.times {
  nxt = {}
  points = {
    x: curr.keys.map { |x, y, z| x }.uniq,
    y: curr.keys.map { |x, y, z| y }.uniq,
    z: curr.keys.map { |x, y, z| z }.uniq
  }

  min = points.map { |k, v| [k, v.min - 1] }.to_h
  max = points.map { |k, v| [k, v.max + 1] }.to_h

  (min[:z]..max[:z]).to_a
    .product((min[:y]..max[:y]).to_a, (min[:x]..max[:x]).to_a).each do |z, y, x|

    c = curr.fetch([x, y, z], INACTIVE)
    neigh_coords = [x - 1, x, x + 1].product([y - 1, y, y + 1], [z - 1, z, z + 1])
      .reject { |nx, ny, nz| nx == x && ny == y && nz == z }

    active_cube = neigh_coords.map { |n| curr.fetch(n, INACTIVE) }.select { |a| a == ACTIVE }

    if c == ACTIVE && active_cube.size.between?(2, 3)
      nxt[[x, y, z]] = ACTIVE
    elsif curr.fetch([x, y, z], INACTIVE) == INACTIVE && active_cube.size == 3
      nxt[[x, y, z]] = ACTIVE
    end
  end

  curr = nxt
}


puts curr.values.select { |c| c == ACTIVE }.size
