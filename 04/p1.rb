#!/usr/bin/env ruby
# frozen_string_literal: true

buf = ''
passports = []
$stdin.each_line.map(&:chomp).map do |line|
  if line != ''
    buf += (buf == '' ? '' : ' ') + line
  else
    passports.append(buf)
    buf = ''
  end
end

valid_count = 0
passports.map do |passport|
  els = passport.split(/[ :]/)
  h = {}
  (0...els.count).step(2).map { |i| h[els[i]] = els[i + 1] }
  h.delete('cid')
  valid_count += 1 if h.keys.count == 7
end

puts valid_count
