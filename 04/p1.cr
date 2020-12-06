#!/usr/bin/env crystal

puts STDIN.gets_to_end
  .split("\n\n")
  .select { |line| line.gsub("\n", ' ')
    .gsub(/cid:\d+ ?/, "")
    .split.size == 7 }
  .size
