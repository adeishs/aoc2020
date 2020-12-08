#!/usr/bin/env ruby
# frozen_string_literal: true

target = 'shiny gold'
rejected = lambda { |spec|
  spec.start_with?(target) || spec.include?('no other ')
}
specs = $stdin.each_line
              .reject { |line| rejected.call(line) }
              .map { |line| line.chomp.gsub(/ bags?/, '').gsub(/\.$/, '') }

contained_by = {}
specs.map do |spec|
  (container, containee) = spec.split(' contain ')
  contained_by[container] = containee.split(', ').map { |c| c.split(' ', 2)[1] }
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
