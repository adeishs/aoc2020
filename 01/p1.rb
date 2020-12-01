#!/usr/bin/env ruby

nums = {}
STDIN.each_line do |line|
  num = line.to_i
  nums[num] = 1

  pair = 2020 - num
  if nums[pair] != nil
    puts (num * pair)
    break
  end
end
