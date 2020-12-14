#!/usr/bin/env ruby

ALL_SET = ('1' * 36).to_i(2)

ins = $stdin.each_line.map(&:chomp)

mask = '1' * 36
mem = {}

ins.each do |i|
  (op, val_s) = i.split(" = ")

  if op == "mask"
    mask = val_s
    next
  end

  loc = op.gsub("mem[", "").gsub("]", "").to_i

  val = val_s.to_i.to_s(2).rjust(36, "0").split("")

  (0...mask.split("").size).each do |b|
    next if mask[b] == 'X'
    val[b] = mask[b]
  end

  mem[loc] = val.join('').to_i(2)
end

puts mem.values.sum
