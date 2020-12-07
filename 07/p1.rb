#!/usr/bin/env ruby

target = 'shiny gold'
specs = STDIN.each_line
  .select { |line| !(line.start_with?(target) || line.include?("no other ")) }
  .map { |line| line.chomp.gsub(/ bags?/, '').gsub(/\.$/, '') }

contained_by = {}
specs.map { |spec|
  lambda { |spec|
    (containing, contained) = spec.split(' contain ')
    contained_by[containing] = contained.split(', ').map {
      |c| c.split(' ', 2)[1]
    }
  }.call(spec)
}

contained_by.keys.each do |k|
  while true
    finished = true
    tmp = contained_by[k].clone
    contained_by[k].each do |clr|
      if !contained_by[clr].nil?
        contained_by[clr].each do |i|
          if !tmp.include?(i)
            tmp.append(i)
            finished = false
          end
        end
      end
    end

    if finished
      break
    end

    contained_by[k] = tmp
  end
end

puts contained_by.keys
                 .select { |k| contained_by[k].include?(target) }
                 .size
