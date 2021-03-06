#!/usr/bin/env ruby
# frozen_string_literal: true

def parse_player_inp(inp)
  lines = inp.split("\n")
  lines.shift
  lines.map { |line| line.chomp.to_i }
end

PLAYERS = [0, 1].freeze

def subgame(decks)
  seen_deck = {}
  loop do
    curr = decks.map { |d| d }
    return [0, decks[0]] if seen_deck.key?(curr)

    seen_deck[curr] = true

    cards = []
    PLAYERS.each { |p| cards << decks[p].shift }

    winner = if PLAYERS.all? { |p| decks[p].size >= cards[p] }
               subgame(PLAYERS.map { |p| decks[p][0...cards[p]] }).shift
             else
               cards[0] > cards[1] ? 0 : 1
             end
    loser = 1 - winner

    [winner, loser].each { |v| decks[winner] << cards[v] }

    return [winner, decks[winner]] if decks[loser].empty?
  end
end

player_recs = $stdin.read.split("\n\n")
decks = player_recs.map { |p| parse_player_inp(p).flatten }
num_of_cards = decks.flatten.size

decks = subgame(decks).pop

puts decks.map.with_index { |v, k| v * (num_of_cards - k) }
          .reduce(&:+)
