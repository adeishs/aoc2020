#!/usr/bin/env crystal

def get_inside_bag_count(clr_cnt, clr)
  return 1 if !clr_cnt.has_key?(clr) || clr_cnt[clr].nil?

  sum = 1
  clr_cnt[clr].each_key do |inside_clr|
    unless clr_cnt[clr][inside_clr].nil?
      sum += clr_cnt[clr][inside_clr] *
             get_inside_bag_count(clr_cnt, inside_clr)
    end
  end

  sum
end

outer_clr = "shiny gold"
specs = STDIN.each_line
  .reject { |line| line.includes?("no other ") }
  .map { |line| line.chomp.gsub(/ bags?/, "").gsub(/\.$/, "") }

clr_cnt = {} of String => Hash(String, Int64)
specs.to_a.map do |s|
  ->(spec : String) {
    containing, contained = spec.split(" contain ")
    clr_cnt[containing] = {} of String => Int64
    contained.split(", ").each do |bag_spec|
      cnt, clr = bag_spec.split(" ", 2)
      clr_cnt[containing][clr] = cnt.to_i64
    end
  }.call(s)
end

puts get_inside_bag_count(clr_cnt, outer_clr) - 1
