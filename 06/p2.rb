#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.read
           .split("\n\n")
           .map { |s|
             lambda { |group_answer_str|
               answers = group_answer_str.split("\n")
               common_answers = answers[0].split('')
               (1...answers.size).each do |i|
                 common_answers &= answers[i].split('')
               end
               common_answers.size
             }.call(s)
           }
           .sum
