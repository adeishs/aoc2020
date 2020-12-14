#!/usr/bin/env ruby
# frozen_string_literal: true

BIN_DIGITS = %w[0 1].freeze
ADDR_SPACE_LEN = 36

def mask_loc(loc, mask)
  x_bits = []
  (0...mask.size).each do |b|
    case mask[b]
    when 'X'
      x_bits << b
    when '1'
      loc[b] = mask[b]
    end
  end

  [loc, x_bits]
end

def get_floats(x_bit_count)
  return [] if x_bit_count.zero?

  xs = BIN_DIGITS
  (x_bit_count - 1).times { xs = xs.product(BIN_DIGITS).map(&:flatten) }
  xs
end

def get_mem_locs(loc, x_bits)
  return [loc] if x_bits.size.zero?

  mem_locs = []
  get_floats(x_bits.size).each do |f|
    (0...x_bits.size).each { |i| loc[x_bits[i]] = f[i] }
    mem_locs << loc.join
  end

  mem_locs
end

mask = '1' * ADDR_SPACE_LEN
mem = {}

$stdin.each_line
      .map { |line| line.chomp.split(' = ') }
      .each do |op, val_s|
  if op == 'mask'
    mask = val_s.split('')
    next
  end

  loc = op.match(/\d+/)[0].to_i.to_s(2).rjust(ADDR_SPACE_LEN, '0').split('')
  val = val_s.to_i
  get_mem_locs(*mask_loc(loc, mask)).each { |ml| mem[ml.to_i(2)] = val }
end

puts mem.values.sum
