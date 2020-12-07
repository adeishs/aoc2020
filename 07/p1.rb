#!/usr/bin/env ruby

target = 'shiny gold'
specs = STDIN.each_line
  .select { |line| !(line.start_with?(target) || line.include?("no other ")) }
  .map { |line| line.gsub(/ bags?/, '').gsub(/\.$/, '').chomp }

contained_by = {}
specs.map { |spec|
  lambda { |spec|
    (containing, contained) = spec.split(' contain ')
    contained_by[containing] = contained.split(', ').map {
      |c|
      lambda { |amt_clr|
        (amt, clr) = amt_clr.split(' ', 2)[1]
      }.call(c)
    }
  }.call(spec)
}

contained_by.keys.each do |k|
  (1..10).each do
    tmp = contained_by[k].clone
    contained_by[k].each do |clr|
      if contained_by[clr] != nil
        contained_by[clr].each do |i|
          tmp.append(i) if !tmp.include?(i)
        end
      end
    end
    contained_by[k] = tmp
  end
end

puts contained_by.keys.select { |k| contained_by[k].include?(target) }.size
