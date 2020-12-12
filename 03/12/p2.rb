#!/usr/bin/env ruby

movements = $stdin.each_line.map(&:chomp)

pos = 0+0i
d = 10+1i

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
    d += Complex(0, val)
  when 'S'
    d -= Complex(0, val)
  when 'E'
    d += val
  when 'W'
    d -= val
  when 'F'
    pos += d * val
  end
end

puts pos.real.abs + pos.imag.abs
