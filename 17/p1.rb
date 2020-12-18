#!/usr/bin/env ruby
# frozen_string_literal: true

INACTIVE = '.'
ACTIVE = '#'

curr = {}

$stdin.each_line
      .map(&:chomp)
      .map.with_index do |line, y|
  line.split('').map.with_index { |c, x| curr[[x, y, 0]] = c }
end

6.times do
  nxt = {}
  points = {
    x: curr.keys.map { |x, _, _| x }.uniq,
    y: curr.keys.map { |_, y, _| y }.uniq,
    z: curr.keys.map { |_, _, z| z }.uniq
  }

  min = points.transform_values { |v| v.min - 1 }
  max = points.transform_values { |v| v.max + 1 }

  (min[:z]..max[:z]).to_a
                    .product((min[:y]..max[:y]).to_a, (min[:x]..max[:x]).to_a)
                    .each do |z, y, x|
    c = curr.fetch([x, y, z], INACTIVE)
    active_cube_count = [x - 1, x, x + 1].product(
      [y - 1, y, y + 1], [z - 1, z, z + 1]
    ).reject { |nx, ny, nz| nx == x && ny == y && nz == z }
      .map { |n| curr.fetch(n, INACTIVE) }
      .select { |a| a == ACTIVE }
      .size

    if (c == ACTIVE && active_cube_count.between?(2, 3)) ||
       (curr.fetch([x, y, z], INACTIVE) == INACTIVE && active_cube_count == 3)
      nxt[[x, y, z]] = ACTIVE
    end
  end

  curr = nxt
end

puts curr.values.select { |c| c == ACTIVE }.size
