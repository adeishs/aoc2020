#!/usr/bin/env ruby
# frozen_string_literal: true

(_, id_str) = $stdin.each_line.map(&:chomp)

ids = id_str.split(',')
buses = (0...ids.size).reject { |d| ids[d] == 'x' }
                      .map { |d| { period: ids[d].to_i, offset: d } }

bus = buses.reduce do |a, b|
  offset = a[:offset]
  offset += a[:period] until ((offset + b[:offset]) % b[:period]).zero?

  {
    period: a[:period] * b[:period],
    offset: offset
  }
end

puts bus[:offset]
