#!/usr/bin/env crystal

ins = STDIN.each_line
  .map { |line| line.chomp.split }
  .to_a

executed = {} of Int32 => Bool
line_num = 0
acc = 0
loop do
  break if executed.has_key?(line_num)

  op, arg = ins[line_num]
  executed[line_num] = true
  if op == "acc"
    acc += arg.to_i32
    line_num += 1
  else
    line_num += op == "jmp" ? arg.to_i32 : 1
  end
end

puts acc
