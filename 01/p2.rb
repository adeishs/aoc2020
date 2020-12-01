#!/usr/bin/env ruby

nums = STDIN.each_line.map do |line|
  line.to_i
end

nums.combination(3) do |c|
  if c.sum == 2020
    puts c.reduce(&:*)
    exit
  end
end
