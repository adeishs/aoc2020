#!/usr/bin/env ruby

def parse_player_inp(inp)
  lines = inp.split("\n")
  lines.shift
  lines.map { |line| line.chomp.to_i }
end

def subgame(decks)
  loop do
    if (0..1).all? { |p| decks[p][0] <= decks[p].size - 1 }
      puts "ENTERING SUBGAME"
      winner = subgame([decks[0][1...decks[0].size],
                        decks[1][1...decks[1].size]])
    else
      winner = decks[0][0] > decks[1][0] ? 0 : 1
    end
    loser = 1 - winner
    [winner, loser].each { |v| decks[winner] << decks[v].shift }

    puts "ROUND WINNER %d" % winner

    return winner if decks[loser].empty?
  end
end

player_recs = $stdin.read.split("\n\n")
decks = player_recs.map { |p| parse_player_inp(p).flatten }
num_of_cards = decks.flatten.size

subgame(decks)

puts decks.flatten
  .map.with_index { |v, k| v * (num_of_cards - k) }
  .reduce { |m, o| m + o }
