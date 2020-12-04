#!/usr/bin/env crystal
# frozen_string_literal: true

puts STDIN.each_line.map { |num| num.to_i64 }.to_a
  .each_combination(3, false)
  .select { |n| n.sum == 2020 }
  .first
  .reduce(1) { |acc, i| acc * i }
