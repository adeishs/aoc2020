#!/usr/bin/env ruby

def get_valid_tickets(field_str)
  valid_ticket = Hash.new(false)
  field_str.scan(/\d+-\d+/).flatten.each do |range|
    (l, u) = range.split('-')
    (l.to_i..u.to_i).each { |i| valid_ticket[i] = true }
  end

  valid_ticket
end

def get_nearby_recs(nearby_str)
  nearby_str.split("\n")
            .map { |line| line.split(',').map(&:to_i) }
end

sections = $stdin.read.split("\n\n")
nearby_str = sections.pop.sub("nearby tickets:\n", '')

valid_ticket = get_valid_tickets(sections.shift)
puts get_nearby_recs(nearby_str).select { |tix|
  tix.any? {
    |t| !valid_ticket[t]
  }
}.map {
  |tix| tix.select { |t| !valid_ticket[t] }.sum
}.sum
