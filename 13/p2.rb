#!/usr/bin/env ruby
# frozen_string_literal: true

(_, id_str) = $stdin.each_line.map(&:chomp)

ids = id_str.split(',')
buses = []
(0...ids.size).each do |d|
  next if ids[d] == 'x'

  buses.append(
    {
      period: ids[d].to_i,
      offset: d
    }
  )
end

bus = buses.reduce do |a, b|
  offset = a[:offset]
  loop do
    offset += a[:period]
    break if ((offset + b[:offset]) % b[:period]).zero?
  end

  {
    period: a[:period] * b[:period],
    offset: offset
  }
end

puts bus[:offset]
