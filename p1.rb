#!/usr/bin/env ruby

PICK_UP_COUNT = 3

cups = $stdin.read.chomp.split('').map(&:to_i)

100.times do
  curr = cups.shift
  cups << curr
  picked_ups = cups.shift(PICK_UP_COUNT)
  dest = ((curr - 1).downto(1) + 9.downto(curr + 1))
    .reject { |n| picked_ups.any? { |p| p == n } }
    .first
  dest_idx = cups.index(dest)

  cups = cups[0..dest_idx] + picked_ups + cups[dest_idx + 1..-1]
end

one_idx = cups.index(1)
puts (cups[one_idx + 1..-1] + cups[0...one_idx]).join('')
