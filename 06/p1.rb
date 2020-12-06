#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.read
           .split("\n\n")
           .map { |answer_str| answer_str.gsub("\n", '').split('').uniq.size }
           .sum
