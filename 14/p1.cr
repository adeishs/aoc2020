#!/usr/bin/env crystal

ADDR_SPACE_LEN = 36

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

    m = op.match(/\d+/)
    loc = m.nil? ? Int64.new(0) : m[0].to_i64
    val = val_s.to_i.to_s(2).rjust(ADDR_SPACE_LEN, '0').each_char.to_a

    (0...mask.size).reject { |b| mask[b] == 'X' }
      .each { |b| val[b] = mask[b] }

    mem[loc] = val.join.to_i64(2)
  end

puts mem.values.sum
