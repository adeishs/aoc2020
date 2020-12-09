#!/usr/bin/env ruby

nums = $stdin.each_line
             .map { |line| line.chomp.to_i }

num_of_nums = nums.size
chunk_size = 25
(0...nums.size - chunk_size).each do |i|
  chunk_nums = nums[0, chunk_size]
  new_num = nums[chunk_size]

  new_num_found = false
  ofs = 0
  (0...chunk_size - 1).each do |j|
    (j + 1...chunk_size).each do |k|
      if chunk_nums[j] + chunk_nums[k] == new_num
        new_num_found = true
        ofs = j
        break
      end
    end

    break if new_num_found
  end

  unless new_num_found
    puts new_num
    break
  end

  nums.shift
  num_of_nums -= 1
end
