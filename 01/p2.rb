#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.each_line.map(&:to_i)
           .combination(3)
           .select { |n| n.sum == 2020 }
           .first
           .reduce(1, :*)
