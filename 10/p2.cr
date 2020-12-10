#!/usr/bin/env crystal

joltages = STDIN.each_line
  .map { |line| line.chomp.to_i64 }
  .to_a
  .sort

joltages.unshift(0)
joltages << joltages.last + 3

alts = Hash(Int32, Int64).new(0)
alts[0] = 1
(1...joltages.size).each do |i|
  (1..[i, 3].min).each do |j|
    alts[i] += alts[i - j] if joltages[i] - joltages[i - j] <= 3
  end
end

puts alts.values.max
