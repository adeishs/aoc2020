#!/usr/bin/env ruby

(rules_str, msgs_str) = $stdin.read.split("\n\n")

rule = Hash[
  *rules_str.split("\n")
    .map { |line| line.split(": ") }
    .map { |k, v| [k, v.gsub('"', '')] }
    .flatten
]

rule.keys.each do |r|
  rule[r] = rule[r].split(' | ')
end

loop do
#  break if /\d/.match(v).rule.values.join.select { |v| /\d/.match(v) }.first.nil?
  break if /\d/.match(rule.values.join).nil?
  rule.keys.each do |r|
#    rule[r] = rule[r].split.map { |t| rule[t].nil? ? t : rule[t] }.join(' ')
    rule[r] = rule[r].map { |t| t.split.map { |x| x.nil? ? x : rule[x] } }.join(' ')
  end
end

puts rule.inspect
rule.keys.each do |r|
  rule[r] = rule[r].split(' | ')
end

puts rule.inspect
exit

#rule = Hash[rule.each_pair.map { |k, v| [k.to_i, v.gsub(' ', '').split('|') ] }]

#valid = Hash[
#  *rule.values
#    .map { |v| v.gsub(' ', '').split('|').map { |msg| [msg, true] } }
#    .flatten
#]

valid = rule[0]
puts valid.inspect

puts msgs_str.split("\n")
#select { |msg| puts valid.any? { |a| a == msg } }

