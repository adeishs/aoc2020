#!/usr/bin/env ruby
# frozen_string_literal: true

ins = $stdin.each_line
            .map { |line| line.chomp.split }
            .map { |op, arg_s| [op, arg_s.to_i] }

executed = {}
line_num = 0
acc = 0
loop do
  break if executed.key?(line_num)

  (op, arg) = ins[line_num]
  executed[line_num] = true
  if op == 'acc'
    acc += arg
    line_num += 1
  else
    line_num += op == 'jmp' ? arg : 1
  end
end

puts acc
