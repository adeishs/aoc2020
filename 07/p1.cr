#!/usr/bin/env crystal

target = "shiny gold"
rejected = ->(spec : String) {
  spec.starts_with?(target) || spec.includes?("no other ")
}
specs = STDIN.each_line
  .reject { |line| rejected.call(line) }
  .map { |line| line.chomp.gsub(/ bags?/, "").gsub(/\.$/, "") }

contained_by = {} of String => Array(String)
specs.to_a.map do |spec|
  container, containee = spec.split(" contain ")
  contained_by[container] = containee.split(", ").map { |c| c.split(" ", 2)[1] }
end

contained_by.each_key do |k|
  loop do
    finished = true
    tmp = contained_by[k].clone
    contained_by[k].each do |clr|
      next if !contained_by.has_key?(clr) || contained_by[clr].nil?

      contained_by[clr].each do |i|
        unless tmp.includes?(i)
          tmp << i
          finished = false
        end
      end
    end

    break if finished

    contained_by[k] = tmp
  end
end

puts contained_by.keys
  .select { |k| contained_by[k].includes?(target) }
  .size
