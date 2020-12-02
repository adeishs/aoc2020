#!/usr/bin/env ruby

def valid(line)
  (min, max, val_ch, password) = line.split(/[- :]+/)
  return (password[min.to_i - 1] == val_ch) ^ (password[max.to_i - 1] == val_ch)
end

puts STDIN.each_line.select { |line| valid(line) }.count
