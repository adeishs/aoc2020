#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.each_line.select { |password_line|
  lambda { |line|
    (min, max, val_ch, password) = line.split(/[- :]+/)
    (password[min.to_i - 1] == val_ch) ^ (password[max.to_i - 1] == val_ch)
  }[password_line]
}.count
