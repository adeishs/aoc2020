#!/usr/bin/env crystal
# frozen_string_literal: true

nums = {} of Int64 => Bool
STDIN.each_line do |line|
  num = line.to_i64
  nums[num] = true

  pair = 2020 - num
  if nums.fetch(pair, false)
    puts(num * pair)
    break
  end
end
