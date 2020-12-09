#!/usr/bin/env ruby
# frozen_string_literal: true

nums = $stdin.each_line
             .map { |line| line.chomp.to_i }

CHUNK_SIZE = 25
loop do
  new_num = nums[CHUNK_SIZE]

  if nums[0, CHUNK_SIZE].combination(2)
                        .select { |p| p.sum == new_num }
                        .empty?
    puts new_num
    break
  end

  nums.shift
end
