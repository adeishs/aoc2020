#!/usr/bin/env crystal

class Inc
  @x = uninitialized Int32

  def initialize(ofs_x : Int32)
    @ofs_x = ofs_x
    @x = -ofs_x
  end

  def inc_x
    @x = (@x + @ofs_x) % 31
  end
end

def count_trees(trees : Array(String), ofs_x : Int32)
  inc = Inc.new ofs_x
  trees.map { |row| row.char_at(inc.inc_x) == '#' }
    .select { |tree| tree }
    .size
end

trees_i = STDIN.each_line.map { |line| line.chomp }
trees = trees_i.to_a

m : UInt64 = 0
m += (1..7).step(2)
  .map { |n| count_trees(trees, n) }
  .reduce { |acc, n| acc * n }

m *= count_trees(
  (0...trees.size).step(2)
    .map { |i| trees[i] }
    .to_a
    .clone,
  1
)

puts m
