#!/usr/bin/env ruby

def valid(line)
  (min, max, val_ch, password) = line.split(/[- :]+/)
  return password.split('').select { |c| c == val_ch }.count.
    between?(min.to_i, max.to_i)
end

puts STDIN.each_line.select { |line| valid(line) }.count
