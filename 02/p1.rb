#!/usr/bin/env ruby

puts STDIN.each_line.select {
  |line| ->(line) {
    (min, max, val_ch, password) = line.split(/[- :]+/)
    password.split('').select { |c| c == val_ch }.count.
      between?(min.to_i, max.to_i)
  }[line]
}.count
