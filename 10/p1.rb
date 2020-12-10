#!/usr/bin/env ruby
# frozen_string_literal: true

joltages = $stdin.each_line
                 .map { |line| line.chomp.to_i }
                 .sort

diff_freq = Hash.new(0)
diff_freq[joltages[0]] = 1
(1...joltages.size).each { |i| diff_freq[joltages[i] - joltages[i - 1]] += 1 }

puts diff_freq[1] * (diff_freq[3] + 1)
