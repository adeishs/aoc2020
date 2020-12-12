#!/usr/bin/env crystal

require "complex"

POS_D = {
  'N' => Complex.new(0, 1),
  'S' => Complex.new(0, -1),
  'E' => Complex.new(1, 0),
  'W' => Complex.new(-1, 0),
}
ROTATOR = {
  'L' => Complex.new(-1, 1),
  'R' => Complex.new(1, -1),
}

movements = STDIN.each_line.map { |line| line.chomp }

pos = Complex.zero
d = Complex.new(1, 0)

movements.each do |line|
  action = line[0]
  val = line[(1...line.size)].to_i

  case action
  when 'L', 'R'
    (0...val).step(90) do |_|
      d = Complex.new(d.imag * ROTATOR[action].real,
        d.real * ROTATOR[action].imag)
    end
  when 'F'
    pos += d * val
  else
    pos += POS_D[action] * val
  end
end

puts (pos.real.abs + pos.imag.abs).to_i
