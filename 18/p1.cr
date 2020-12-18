#!/usr/bin/env crystal

def eval_expr(expr)
  loop do
    start = expr.index("(")
    break if start.nil?

    open = 0
    close = 0
    finish = start
    (start...expr.size).each do |i|
      case expr[i, 1]
      when "("
        open += 1
      when ")"
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
  acc = tokens.shift.to_i64
  until tokens.size.zero?
    op = tokens.shift
    y = tokens.shift.to_i64

    if op == "+"
      acc += y
    else
      acc *= y
    end
  end
  acc
end

puts STDIN.each_line.map { |line| eval_expr(line.chomp) }.sum
