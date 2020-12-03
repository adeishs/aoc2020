#!/usr/bin/env ruby

trees = STDIN.each_line.map { |line| line.chomp }
m = (1..7).step(2).map {
  |n| ->(n) {
    inc_x = -> {
      x = -n
      -> { x = (x + n) % 31 }
    }
    x = inc_x[]
    trees.map { |row| row.split('')[x[]] == '#' }.
      select { |tree| tree }.
      count
  }[n]
}.reduce(1, :*)

trees = (0...trees.count).select(&:even?).map { |i| trees[i] }

n = 1
inc_x = -> {
  x = -n
  -> { x = (x + n) % 31 }
}
x = inc_x[]
m *= trees.map { |row| row.split('')[x[]] == '#' }.
  select { |tree| tree }.
  count

puts m
