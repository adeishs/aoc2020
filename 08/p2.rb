#!/usr/bin/env ruby
# frozen_string_literal: true

ins = $stdin.each_line
            .map { |line| line.chomp.split }
            .map { |op, arg_s| [op, arg_s.to_i] }

(0...ins.size).each do |fix_line_num|
  next if ins[fix_line_num][0] == 'acc'

  fixed_ins = ins.clone
  fixed_ins[fix_line_num] = [
    ins[fix_line_num][0] == 'jmp' ? 'nop' : 'jmp',
    ins[fix_line_num][1]
  ]

  executed = {}
  line_num = 0
  acc = 0
  loop do
    break if executed.key?(line_num)

    (op, arg) = fixed_ins[line_num]
    executed[line_num] = true
    if op == 'acc'
      acc += arg
      line_num += 1
    else
      line_num += op == 'jmp' ? arg : 1
    end

    if line_num == ins.size
      puts acc
      exit
    end
  end
end
