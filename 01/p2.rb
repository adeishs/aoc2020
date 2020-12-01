#!/usr/bin/env ruby

nums = []
STDIN.each_line do |line|
  nums.append(line.to_i)
end

n = nums.count
for i in 0..n - 3
  for j in i..n - 2
    for k in j..n - 1
      if nums[i] + nums[j] + nums[k] == 2020
        puts (nums[i] * nums[j] * nums[k])
        exit
      end
    end
  end
end
