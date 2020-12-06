#!/usr/bin/env crystal

puts STDIN.gets_to_end
  .split("\n\n")
  .map { |answer_str| answer_str.gsub("\n", "").chars.uniq.size }
  .sum
