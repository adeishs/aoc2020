#!/usr/bin/env crystal

def eval_ltr(tokens, op)
  acc = 0.to_i64
  loop do
    pos = tokens.index(op)
    break if pos.nil?

    x = tokens[pos - 1].to_i64
    y = tokens[pos + 1].to_i64

    if op == "+"
      acc = x + y
    else
      acc = x * y
    end
    tokens[pos - 1..pos + 1] = [acc.to_s]
  end

  tokens
end

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

  eval_ltr(eval_ltr(expr.split, "+"), "*").first.to_i64
end

puts STDIN.each_line.map { |line| eval_expr(line.chomp) }.sum
