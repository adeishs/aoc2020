#!/usr/bin/env crystal

require "complex"

POS_D = {
  "N" => Complex.new(0, 1),
  "S" => Complex.new(0, -1),
  "E" => Complex.new(1, 0),
  "W" => Complex.new(-1, 0),
}
ROTATOR = {
  "L" => Complex.new(-1, 1),
  "R" => Complex.new(1, -1),
}

pos = Complex.zero
d = Complex.new(1, 0)

STDIN.each_line do |line|
  action, val_s = line.chomp.split("", 2)
  val = val_s.to_i

  if ["L", "R"].any? { |a| a == action }
    (0...val).step(90) do |_|
      d = Complex.new(d.imag * ROTATOR[action].real,
        d.real * ROTATOR[action].imag)
    end
  else
    pos += (action == "F" ? d : POS_D[action]) * val
  end
end

puts (pos.real.abs + pos.imag.abs).to_i
