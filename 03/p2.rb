#!/usr/bin/env ruby
# frozen_string_literal: true

trees = $stdin.each_line.map(&:chomp)
m = (1..7).step(2).map do |n|
  lambda { |x_ofs|
    x = -x_ofs
    inc_x = lambda {
      x = (x + x_ofs) % 31
    }
    trees.select { |row| row.split('')[inc_x[]] == '#' }
         .count
  }[n]
end.reduce(1, :*)

trees = (0...trees.count).select(&:even?).map { |i| trees[i] }

x_ofs = 1
x = -x_ofs
inc_x = lambda {
  x = (x + x_ofs) % 31
}
m *= trees.select { |row| row.split('')[inc_x[]] == '#' }
          .count

puts m
