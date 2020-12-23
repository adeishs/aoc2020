#!/usr/bin/env ruby

def parse_player_inp(inp)
  lines = inp.split("\n")
  lines.shift
  lines.map { |line| line.chomp.to_i }
end

def subgame(decks)
  seen_deck = {}
  while !decks[0].empty? && !decks[1].empty?
    curr = [decks[0], decks[1]]
    return [0, decks[0]] if seen_deck.has_key?(curr)
    seen_deck[curr] = true

    card = {}
    card[0] = decks[0].shift
    card[1] = decks[1].shift

    if (0..1).all? { |p| decks[p].size >= card[p] }
      winner = subgame([decks[0][0...card[0]].clone, decks[1][0...card[1]].clone])
        .shift
    else
      winner = card[0] > card[1] ? 0 : 1
    end
    loser = 1 - winner

    [winner, loser].each { |v| decks[winner] << card[v] }
    
    return [winner, decks[winner]] if decks[loser].empty?
  end
end

player_recs = $stdin.read.split("\n\n")
decks = player_recs.map { |p| parse_player_inp(p).flatten }
num_of_cards = decks.flatten.size

(winner, decks) = subgame(decks)

puts decks
  .map.with_index { |v, k| v * (num_of_cards - k) }
  .reduce { |m, o| m + o }
