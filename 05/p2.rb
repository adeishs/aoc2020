#!/usr/bin/env ruby
# frozen_string_literal: true

passes = $stdin.each_line
               .map { |pass| pass.tr('BRFL', '1100').to_i(2) }
               .sort

(0...passes.size - 1).each do |i|
  if passes[i + 1] - passes[i] != 1
    puts passes[i + 1] - 1
    break
  end
end
