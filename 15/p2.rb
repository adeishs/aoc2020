#!/usr/bin/env ruby
# frozen_string_literal: true

nums = $stdin.read.chomp.split(',').map(&:to_i)

last_spoken = {}
(0...nums.size).map { |turn| last_spoken[nums[turn]] = [turn] }

(nums.size...30000000).each do |turn|
  last_num = nums[turn - 1]
  new_num = if last_spoken[last_num].nil? || last_spoken[last_num].size == 1
              0
            else
              last_spoken[last_num][0] - last_spoken[last_num][1]
            end

  last_spoken[new_num] = [] if last_spoken[new_num].nil?
  last_spoken[new_num].unshift(turn)
  nums << new_num
end

puts nums.last
