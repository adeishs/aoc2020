#!/usr/bin/env ruby
# frozen_string_literal: true

EMPTY = 'L'
OCCUPIED = '#'
FLOOR = '.'
DS = [-1, 0, 1].freeze
DIRS = DS.product(DS).reject { |y, x| x.zero? && y.zero? }

def outside_boundary?(row, col, seats)
  !row.between?(0, seats.size - 1) ||
    !col.between?(0, seats[0].size - 1)
end

def check_seats(seats, length, i, j)
  num_of_occupied_seats = 0
  DIRS.each do |y, x|
    (1..length).each do |dist|
      row = i + dist * y
      col = j + dist * x

      break if outside_boundary?(row, col, seats)
      next if seats[row][col] == FLOOR

      num_of_occupied_seats += 1 if seats[row][col] == OCCUPIED
      break
    end
    break if num_of_occupied_seats.positive? && seats[i][j] == EMPTY
  end

  num_of_occupied_seats
end

prev = $stdin.each_line
                  .map { |line| line.chomp.split('') }

length = [prev.size, prev[0].size].max
curr = []

loop do
  curr = (0...prev.size).map do |i|
    (0...prev[i].size).map do |j|
      if prev[i][j] == EMPTY
        check_seats(prev, length, i, j).positive? ? EMPTY : OCCUPIED
      elsif prev[i][j] == OCCUPIED && check_seats(prev, length, i, j) >= 5
        EMPTY
      else
        prev[i][j]
      end
    end
  end

  break if prev == curr

  prev = curr.clone
end

puts curr.flatten
         .select { |c| c == OCCUPIED }
         .size
