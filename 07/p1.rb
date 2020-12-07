#!/usr/bin/env ruby
# frozen_string_literal: true

target = 'shiny gold'
specs = $stdin.each_line
              .reject do |line|
                line.start_with?(target) || line.include?('no other ')
              end
              .map { |line| line.chomp.gsub(/ bags?/, '').gsub(/\.$/, '') }

contained_by = {}
specs.map do |s|
  lambda { |spec|
    (containing, contained) = spec.split(' contain ')
    contained_by[containing] = contained.split(', ').map do |c|
      c.split(' ', 2)[1]
    end
  }.call(s)
end

contained_by.each_key do |k|
  loop do
    finished = true
    tmp = contained_by[k].clone
    contained_by[k].each do |clr|
      next if contained_by[clr].nil?

      contained_by[clr].each do |i|
        unless tmp.include?(i)
          tmp.append(i)
          finished = false
        end
      end
    end

    break if finished

    contained_by[k] = tmp
  end
end

puts contained_by.keys
                 .select { |k| contained_by[k].include?(target) }
                 .size
