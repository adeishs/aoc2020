#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.read
           .split("\n\n")
           .map { |line| Hash[*line.gsub("\n", ' ')
                                   .gsub(/cid:\d+ ?/, '')
                                   .split(/[ :]/)].keys.count == 7 }
           .select { |valid| valid }
           .count
