#!/usr/bin/env crystal

puts STDIN.gets_to_end
  .split("\n\n")
  .map { |s|
    ->(group_answer_str : String) {
      answers = group_answer_str.split("\n")
      answers.reduce { |acc, a| (acc.chars & a.chars).join("") }.size
    }.call(s)
  }
  .sum
