#!/usr/bin/env ruby
# frozen_string_literal: true

def eval_ltr(tokens, op)
  acc = 0
  loop do
    pos = tokens.find_index(op)
    break if pos.nil?

    x = tokens[pos - 1].to_i
    y = tokens[pos + 1].to_i

    acc = x.public_send op, y
    tokens[pos - 1..pos + 1] = [acc.to_s]
  end

  tokens
end

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

  eval_ltr(eval_ltr(expr.split, '+'), '*').first.to_i
end

puts $stdin.each_line.map { |line| eval_expr(line.chomp) }.sum
