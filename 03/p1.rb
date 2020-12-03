#!/usr/bin/env ruby

def inc_x(n)
  x = -n
  -> { x = (x + n) % 31 }
end

x = inc_x(3)
puts STDIN.each_line.
  map { |line| line.chomp }.
  map { |row| row.split('')[x[]] == '#' }.
  select { |tree| tree }.
  count
