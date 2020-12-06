#!/usr/bin/env crystal

puts STDIN.gets_to_end
  .split("\n\n")
  .map { |s|
    ->(group_answer_str : String) {
      answers = group_answer_str.split("\n")
      common_answers = answers[0].split("")
      (1...answers.size).each do |i|
        common_answers &= answers[i].split("")
      end
      common_answers.size
    }.call(s)
  }
  .sum
