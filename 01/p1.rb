#!/usr/bin/env ruby
# frozen_string_literal: true

nums = {}
$stdin.each_line do |line|
  num = line.to_i
  nums[num] = 1

  pair = 2020 - num
  unless nums[pair].nil?
    puts(num * pair)
    break
  end
end
