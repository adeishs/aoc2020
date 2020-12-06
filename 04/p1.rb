#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.read
           .split("\n\n")
           .select { |line|
             Hash[*line.gsub("\n", ' ')
                       .gsub(/cid:\d+ ?/, '')
                       .split(/[ :]/)]
               .keys.count == 7
           }
           .count
