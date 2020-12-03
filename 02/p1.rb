#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.each_line.select { |password_line|
  lambda { |line|
    (min, max, val_ch, password) = line.split(/[- :]+/)
    password.split('').select { |c| c == val_ch }.count
            .between?(min.to_i, max.to_i)
  }[password_line]
}.count
