#!/usr/bin/env ruby
# frozen_string_literal: true

raw_nums = $stdin.each_line
                 .map { |line| line.chomp.to_i }
nums = raw_nums.clone

CHUNK_SIZE = 25
invalid_num = 0
loop do
  new_num = nums[CHUNK_SIZE]

  if nums[0, CHUNK_SIZE].combination(2)
                        .select { |p| p.sum == new_num }
                        .empty?
    invalid_num = new_num
    break
  end

  nums.shift
end

(2...raw_nums.size).each do |set_size|
  (0...raw_nums.size - set_size).each do |start|
    chunk_nums = raw_nums[start, set_size]
    if chunk_nums.sum == invalid_num
      puts chunk_nums.min + chunk_nums.max
      exit
    end
  end
end
