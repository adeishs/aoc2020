#!/usr/bin/env crystal

nums = STDIN.each_line
  .map { |line| line.chomp.to_i64 }
  .to_a

CHUNK_SIZE = 25
loop do
  new_num = nums[CHUNK_SIZE]

  if nums[0, CHUNK_SIZE].combinations(2)
       .select { |p| p.sum == new_num }
       .empty?
    puts new_num
    break
  end

  nums.shift
end
