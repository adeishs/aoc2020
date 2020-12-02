#!/usr/bin/env ruby

puts STDIN.each_line.select {
  |line| ->(line) {
    (min, max, val_ch, password) = line.split(/[- :]+/)
    (password[min.to_i - 1] == val_ch) ^ (password[max.to_i - 1] == val_ch)
  }[line]
}.count
