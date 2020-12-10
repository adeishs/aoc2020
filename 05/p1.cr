#!/usr/bin/env crystal

puts STDIN.each_line
  .map { |pass| pass.tr("BRFL", "1100").to_i(2) }
  .max
