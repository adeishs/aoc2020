#!/usr/bin/env crystal

BIN_DIGITS     = [['0'], ['1']]
ADDR_SPACE_LEN = 36

def get_loc(op)
  m = op.match(/\d+/)
  return [] of Char if m.nil?

  m[0].to_i64.to_s(2).rjust(ADDR_SPACE_LEN, '0').each_char.to_a
end

def mask_loc(loc, mask)
  x_bits = [] of Int32
  (0...mask.size).each do |b|
    case mask[b]
    when 'X'
      x_bits << b
    when '1'
      loc[b] = mask[b]
    end
  end

  {loc, x_bits}
end

def get_floats(x_bit_count)
  return [] of Array(Char) if x_bit_count.zero?

  xs = BIN_DIGITS
  (x_bit_count - 1).times {
    xs = xs.product(BIN_DIGITS).map { |t|
      a, b = t
      a + b
    }
  }
  xs
end

def get_mem_locs(loc, x_bits)
  return [loc.join] if x_bits.size.zero?

  mem_locs = [] of String
  get_floats(x_bits.size).each do |f|
    (0...x_bits.size).each { |i| loc[x_bits[i]] = f[i] }
    mem_locs << loc.join
  end

  mem_locs
end

mask = "1" * ADDR_SPACE_LEN
mem = {} of Int64 => Int64

STDIN.each_line
  .map { |line| line.chomp.split(" = ") }
  .each do |line|
    op, val_s = line
    if op == "mask"
      mask = val_s.each_char.to_a
      next
    end

    loc = get_loc(op)
    val = val_s.to_i64
    get_mem_locs(*mask_loc(loc, mask)).each { |ml| mem[ml.to_i64(2)] = val }
  end

puts mem.values.sum
