#!/usr/bin/env ruby
# frozen_string_literal: true

BIN_DIGITS = ["0", "1"]

mask = '1' * 36
mem = Hash.new(0)

$stdin.each_line.map(&:chomp).each do |i|
  (op, val_s) = i.split(' = ')

  if op == 'mask'
    mask = val_s
    next
  end

  loc = op.gsub(/(^mem\[|\]$)/, '').to_i.to_s(2).rjust(36, '0').split('')
  val = val_s.to_i

  x_count = 0
  float_bits = Hash.new(0)
  (0...mask.split('').size).each do |b|
    next if mask[b] == '0'

    if mask[b] == 'X'
      float_bits[x_count] = b
      x_count += 1
    end

    loc[b] = mask[b]
  end

  mem_locs = []
  if x_count.zero?
    mem_locs.append(loc)
  else
    floats = BIN_DIGITS
    (1...x_count).each do |_|
      floats = floats.product(BIN_DIGITS).map { |a| a.flatten }
    end

    floats.each do |f|
      (0...x_count).each do |i|
        loc[float_bits[i]] = f[i]
      end
      mem_locs.append(loc.join(''))
    end
  end

  mem_locs.each { |ml| mem[ml.to_i(2)] = val }
end

puts mem.values.sum
