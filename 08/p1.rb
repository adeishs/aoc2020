#!/usr/bin/env ruby
# frozen_string_literal: true

ins = []
$stdin.each_line.map do |line|
  (op, arg_s) = line.chomp.split
  arg = arg_s.to_i
  ins.append([op, arg])
end

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
