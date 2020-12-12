#!/usr/bin/env ruby

movements = $stdin.each_line.map(&:chomp)

pos = 0+0i
d = 1+0i

movements.each do |line|
  action = line[0]
  val = line[(1...line.length)].to_i

  case action
  when 'L'
    (0...val).step(90) do loop
      d = Complex(-d.imag, d.real)
    end
  when 'R'
    (0...val).step(90) do loop
      d = Complex(d.imag, -d.real)
    end
  when 'N'
    pos += Complex(0, val)
  when 'S'
    pos -= Complex(0, val)
  when 'E'
    pos += val
  when 'W'
    pos -= val
  when 'F'
    pos += d * val
  end
end

puts pos.real.abs + pos.imag.abs
