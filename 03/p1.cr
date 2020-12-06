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

inc = Inc.new 3

puts STDIN.each_line
  .map { |row| row[inc.inc_x] == '#' }
  .select { |tree| tree }
  .size
