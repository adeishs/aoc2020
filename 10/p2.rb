#!/usr/bin/env ruby

joltages = $stdin.each_line
  .map { |line| line.chomp.to_i }
  .sort

joltages.unshift(0)
joltages.append(joltages.last + 3)

alts = Hash.new(0)
alts[0] = 1
(1...joltages.size).each do |i|
  (1..[i, 3].min).each do |j|
    alts[i] += alts[i - j] if joltages[i] - joltages[i - j] <= 3
  end
end

puts alts.max
