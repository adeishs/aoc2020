#!/usr/bin/env ruby
# frozen_string_literal: true

def get_inside_bag_count(clr_cnt, clr)
  return 1 if clr_cnt[clr].nil?

  sum = 1
  clr_cnt[clr].each_key do |inside_clr|
    unless clr_cnt[clr][inside_clr].nil?
      sum += clr_cnt[clr][inside_clr] *
             get_inside_bag_count(clr_cnt, inside_clr)
    end
  end

  sum
end

outer_clr = 'shiny gold'
specs = $stdin.each_line
              .reject { |line| line.include?('no other ') }
              .map { |line| line.chomp.gsub(/ bags?/, '').gsub(/\.$/, '') }

clr_cnt = {}
specs.map do |s|
  lambda { |spec|
    (containing, contained) = spec.split(' contain ')
    clr_cnt[containing] = {}
    contained.split(', ').each do |bag_spec|
      (cnt, clr) = bag_spec.split(' ', 2)
      clr_cnt[containing][clr] = cnt.to_i
    end
  }.call(s)
end

puts get_inside_bag_count(clr_cnt, outer_clr) - 1
