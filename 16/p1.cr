#!/usr/bin/env crystal

def get_valid_tickets(field_str)
  valid_ticket = {} of Int32 => Bool
  field_str.scan(/\d+-\d+/).flatten.each do |range|
    l, u = range.not_nil![0].split("-")
    (l.to_i..u.to_i).each { |i| valid_ticket[i] = true }
  end

  valid_ticket
end

def get_nearby_recs(nearby_str)
  nearby_str.split("\n")
    .map { |line| line.split(",").map { |n| n.to_i } }
end

sections = STDIN.gets_to_end.split("\n\n")
nearby_str = sections.pop.sub("nearby tickets:\n", "")

valid_ticket = get_valid_tickets(sections.shift)
puts get_nearby_recs(nearby_str).select { |tix|
  tix.any? { |t| !valid_ticket.fetch(t, false) }
}.map { |tix| tix.reject { |t| valid_ticket.fetch(t, false) }.sum }.sum
