#!/usr/bin/env ruby
# frozen_string_literal: true

def valid_passport(passport)
  els = passport.split(/[ :]/)
  h = {}
  (0...els.count).step(2).map { |i| h[els[i]] = els[i + 1] }
  h.keys.count == 7
end

puts $stdin.read
           .split("\n\n")
           .map { |line| valid_passport(line.gsub("\n", ' ')
                                            .gsub(/cid:\d+ ?/, '')) }
           .select { |valid| valid }
           .count
