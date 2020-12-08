#!/usr/bin/env crystal

ins = STDIN.each_line
  .map { |line| line.chomp.split }
  .to_a

(0...ins.size).each do |fix_line_num|
  next if ins[fix_line_num][0] == "acc"

  fixed_ins = ins.clone
  fixed_ins[fix_line_num] = [
    ins[fix_line_num][0] == "jmp" ? "nop" : "jmp",
    ins[fix_line_num][1],
  ]

  executed = {} of Int32 => Bool
  line_num = 0
  acc = 0
  loop do
    break if executed.has_key?(line_num)

    op, arg = fixed_ins[line_num]
    executed[line_num] = true
    if op == "acc"
      acc += arg.to_i32
      line_num += 1
    else
      line_num += op == "jmp" ? arg.to_i32 : 1
    end

    if line_num == ins.size
      puts acc
      exit
    end
  end
end
