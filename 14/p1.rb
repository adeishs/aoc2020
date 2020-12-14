#!/usr/bin/env ruby
# frozen_string_literal: true

ADDR_SPACE_LEN = 36

mask = '1' * ADDR_SPACE_LEN
mem = {}

$stdin.each_line
      .map { |line| line.chomp.split(' = ') }
      .each do |op, val_s|
  if op == 'mask'
    mask = val_s.split('')
    next
  end

  loc = op.match(/\d+/)[0].to_i
  val = val_s.to_i.to_s(2).rjust(ADDR_SPACE_LEN, '0').split('')

  (0...mask.size).reject { |b| mask[b] == 'X' }
                 .each { |b| val[b] = mask[b] }

  mem[loc] = val.join.to_i(2)
end

puts mem.values.sum
