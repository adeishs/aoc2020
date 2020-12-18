#!/usr/bin/env ruby
# frozen_string_literal: true

def eval_expr(expr)
  loop do
    start = expr.index('(')
    break if start.nil?

    open = 0
    close = 0
    finish = start
    (start...expr.size).each do |i|
      case expr[i]
      when '('
        open += 1
      when ')'
        close += 1
      end

      if open == close
        finish = i
        break
      end
    end

    expr = expr[0...start] +
           eval_expr(expr[start + 1...finish]).to_s +
           expr[finish + 1...expr.size]
  end

  tokens = expr.split
  acc = 0
  loop do
    pos = tokens.find_index('+')
    break if pos.nil?

    acc = tokens[pos - 1].to_i + tokens[pos + 1].to_i
    tokens[pos - 1..pos + 1] = [acc.to_s]
  end
  acc = tokens[0].to_i

  loop do
    pos = tokens.find_index('*')
    break if pos.nil?

    acc = tokens[pos - 1].to_i * tokens[pos + 1].to_i
    tokens[pos - 1..pos + 1] = [acc.to_s]
  end
  tokens[0].to_i
end

puts $stdin.each_line.map { |line| eval_expr(line.chomp) }.sum
