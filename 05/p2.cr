#!/usr/bin/env crystal

passes = STDIN.each_line
  .map { |pass| pass.tr("BRFL", "1100").to_i(2) }
  .to_a
  .sort

(0...passes.size - 1).each do |i|
  if passes[i + 1] - passes[i] != 1
    puts passes[i + 1] - 1
    break
  end
end
