#!/usr/bin/env ruby
# frozen_string_literal: true

def inc_x(x_ofs)
  x = -x_ofs
  -> { x = (x + x_ofs) % 31 }
end

x = inc_x(3)
puts $stdin.each_line
           .map(&:chomp)
           .select { |row| row.split('')[x[]] == '#' }
           .count
