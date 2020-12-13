#!/usr/bin/env crystal

id_str = STDIN.each_line.map { |line| line.chomp }.to_a.pop

ids = id_str.split(",")
buses = (0...ids.size).reject { |d| ids[d] == "x" }
  .map { |d| {period: ids[d].to_i64, offset: d.to_i64} }

bus = buses.reduce do |a, b|
  offset = a[:offset]
  loop do
    offset += a[:period]
    break if ((offset + b[:offset]) % b[:period]).zero?
  end

  {
    period: a[:period] * b[:period],
    offset: offset,
  }
end

puts bus[:offset]
