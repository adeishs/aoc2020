#!/usr/bin/env crystal

require "complex"

movements = STDIN.each_line.map { |line| line.chomp }

pos = Complex.zero
d = Complex.new(1, 0)

movements.each do |line|
  action = line[0]
  val = line[(1...line.size)].to_i

  case action
  when 'L'
    (0...val).step(90) do |_|
      d = Complex.new(-d.imag, d.real)
    end
  when 'R'
    (0...val).step(90) do |_|
      d = Complex.new(d.imag, -d.real)
    end
  when 'N'
    pos += Complex.new(0, val)
  when 'S'
    pos -= Complex.new(0, val)
  when 'E'
    pos += val
  when 'W'
    pos -= val
  when 'F'
    pos += d * val
  end
end

puts (pos.real.abs + pos.imag.abs).to_i
