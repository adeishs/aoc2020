#!/usr/bin/env ruby
# frozen_string_literal: true

target = 'shiny gold'
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

inside = ->(clr) {
  return 1 if clr_cnt[clr].nil?

  sum = 1
  clr_cnt[clr].each_key do |o|
    unless clr_cnt[clr][o].nil?
      sum += clr_cnt[clr][o] * inside.call(o)
    end
  end

  sum
}

puts inside.call(target) - 1
