#!/usr/bin/env crystal

nums = STDIN.gets_to_end.chomp.split(",").map { |n| n.to_i64 }

last_spoken = {} of Int64 => Array(Int64)
(0...nums.size).map { |turn| last_spoken[nums[turn.to_i64]] = [turn.to_i64] }

(nums.size.to_i64...30000000.to_i64).each do |turn|
  last_num = nums[turn - 1]
  new_num = if last_spoken[last_num].nil? || last_spoken[last_num].size == 1
              0.to_i64
            else
              last_spoken[last_num].last -
                last_spoken[last_num][last_spoken[last_num].size - 2]
            end

  last_spoken[new_num] = [] of Int64 unless last_spoken.has_key?(new_num)
  last_spoken[new_num] << turn
  nums << new_num
end

puts nums.last
