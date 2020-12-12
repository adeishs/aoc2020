#!/usr/bin/env ruby
# frozen_string_literal: true

POS_D = {
  'N' => 0 + 1i,
  'S' => 0 - 1i,
  'E' => 1 + 0i,
  'W' => -1 + 0i
}.freeze
ROTATOR = {
  'L' => -1 + 1i,
  'R' => 1 - 1i
}.freeze

pos = 0 + 0i
d = POS_D['E']

$stdin.each_line
      .map { |line| line.chomp.split('', 2) }
      .map { |action, val_s| [action, val_s.to_i] }
      .each do |action, val|
  if %w[L R].any? { |a| a == action }
    (0...val).step(90) do
      loop
      d = Complex(d.imag * ROTATOR[action].real, d.real * ROTATOR[action].imag)
    end
  else
    pos += (action == 'F' ? d : POS_D[action]) * val
  end
end

puts pos.real.abs + pos.imag.abs
