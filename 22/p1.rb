#!/usr/bin/env ruby

def parse_player_inp(inp)
  lines = inp.split("\n")
  lines.shift
  lines.map { |line| line.chomp.to_i }
end

player_recs = $stdin.read.split("\n\n")
deck = player_recs.map { |p| parse_player_inp(p).flatten }
num_of_cards = deck.flatten.size

loop do
  break if (0..1).any? { |p| deck[p].empty? }

  winner = deck[0][0] > deck[1][0] ? 0 : 1
  [winner, 1 - winner].each { |v| deck[winner] << deck[v].shift }
end

puts deck.flatten
  .map.with_index { |v, k| v * (num_of_cards - k) }
  .reduce { |m, o| m + o }
