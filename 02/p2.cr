#!/usr/bin/env crystal
# frozen_string_literal: true

puts STDIN.each_line.select { |password_line|
  ->(line : String) {
    min, max, val_ch, password = line.split(/[- :]+/)
    (password[min.to_i - 1, 1] == val_ch) ^
      (password[max.to_i - 1, 1] == val_ch)
  }.call(password_line)
}.size
