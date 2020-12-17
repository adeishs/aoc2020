#!/usr/bin/env ruby
# frozen_string_literal: true

require 'set'

def get_valid_tickets(field_str)
  valid_ticket = Hash.new(false)
  field_str.scan(/\d+-\d+/).flatten.each do |range|
    (l, u) = range.split('-')
    (l.to_i..u.to_i).each { |i| valid_ticket[i] = true }
  end

  valid_ticket
end

def parse_field_range_set_str(field_range_set_str)
    field_range_set_str.split(' or ').map do |field_range_str|
      Range.new(*field_range_str.split('-').map(&:to_i)).to_a
    end.reduce { |m, o| m | o }
end

def get_field_tickets(field_str)
  field_range = {}
  field_str.split("\n")
           .each do |line|
    (field_name, field_range_set_str) = line.split(': ')
    field_range[field_name] = parse_field_range_set_str(field_range_set_str)
  end

  field_range
end

def get_nearby_recs(nearby_str)
  nearby_str.split("\n")
            .map { |line| line.split(',').map(&:to_i) }
end

def get_field_order(field_tickets_in, nearby_recs_in)
  field_tickets = field_tickets_in.clone
  nearby_recs = nearby_recs_in.transpose
  possible_fields = []
  fields = []
  (0...nearby_recs.size).each do |i|
    possible_fields[i] = {}
    good_field = nil
    field_tickets.keys.each do |field|
      if (nearby_recs[i] - field_tickets[field]).empty?
        possible_fields[i][field] = true
      end
    end
  end

  loop do
    min_size = field_tickets.size
    min_idx = nil
    (0...possible_fields.size).each do |i|
      if possible_fields[i].keys.size > 0 && possible_fields[i].keys.size < min_size
        min_size = possible_fields[i].keys.size
        min_idx = i
      end
    end
    
    break if min_idx.nil?
    field = possible_fields[min_idx].keys.first
    fields[min_idx] = field
    (0...possible_fields.size).each { |i| possible_fields[i].delete(field) }
  end

  fields
end

sections = $stdin.read.split("\n\n")
nearby_str = sections.pop.sub("nearby tickets:\n", '')
field_str = sections.shift

valid_ticket = get_valid_tickets(field_str)
field_tickets = get_field_tickets(field_str)
#nearby_recs = get_nearby_recs(nearby_str)
nearby_recs = get_nearby_recs(nearby_str).reject do |tix|
  tix.any? { |t| !valid_ticket[t] }
end
fields = get_field_order(field_tickets, nearby_recs)
your_tickets = sections.shift.gsub("your ticket:\n", '').split(',').map(&:to_i)
departure_idxs = (0...fields.size).select { |i| fields[i].start_with?('departure') }
puts departure_idxs.map { |i| your_tickets[i] }.reduce(1, :*)
