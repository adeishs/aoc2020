#!/usr/bin/env ruby

puts STDIN.each_line.map { |line| line.to_i }.
  combination(3).
  select { |n| n.sum == 2020 }.
  first.
  reduce(1, :*)
