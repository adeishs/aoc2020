#!/usr/bin/env ruby
# frozen_string_literal: true

mask = '1' * 36
mem = {}

$stdin.each_line.map(&:chomp).each do |i|
  (op, val_s) = i.split(' = ')

  if op == 'mask'
    mask = val_s
    next
  end

  loc = op.gsub(/(^mem\[|\]$)/, '').to_i
  val = val_s.to_i.to_s(2).rjust(36, '0').split('')

  (0...mask.split('').size).each do |b|
    next if mask[b] == 'X'
    val[b] = mask[b]
  end

  mem[loc] = val.join('').to_i(2)
end

puts mem.values.sum
