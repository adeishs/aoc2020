#!/usr/bin/env crystal

def bin_to_dec(str, set_char)
  (0...str.size).map { |i| str[str.size - 1 - i] == set_char ? 1 << i : 0 }
    .sum
end

puts STDIN.each_line
  .map { |pass|
    bin_to_dec(pass[0, 7], 'B') * 8 + bin_to_dec(pass[7, 3], 'R')
  }
  .max