#!/usr/bin/env ruby
# frozen_string_literal: true

trees = $stdin.each_line.map(&:chomp)
m = (1..7).step(2).map do |n|
  lambda { |x_ofs|
    inc_x = lambda {
      x = -x_ofs
      -> { x = (x + x_ofs) % 31 }
    }
    x = inc_x[]
    trees.map { |row| row.split('')[x[]] == '#' }
         .select { |tree| tree }
         .count
  }[n]
end.reduce(1, :*)

trees = (0...trees.count).select(&:even?).map { |i| trees[i] }

x_ofs = 1
inc_x = lambda {
  x = -x_ofs
  -> { x = (x + x_ofs) % 31 }
}
x = inc_x[]
m *= trees.map { |row| row.split('')[x[]] == '#' }
          .select { |tree| tree }
          .count

puts m
