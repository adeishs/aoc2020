#!/usr/bin/env crystal
# frozen_string_literal: true

puts STDIN.each_line.select { |password_line|
  ->(line : String) {
    min, max, val_ch, password = line.split(/[- :]+/)
    freq = password.split("").select { |c| c == val_ch }.size
    min.to_i32 <= freq && freq <= max.to_i32
  }.call(password_line)
}.size
