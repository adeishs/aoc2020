#!/usr/bin/env ruby
# frozen_string_literal: true

EMPTY = 'L'
OCCUPIED = '#'
FLOOR = '.'
DS = [-1, 0, 1].freeze
DIRS = DS.product(DS).reject { |y, x| x.zero? && y.zero? }

def outside_boundary?(row, col, seats)
  !row.between?(0, seats.size - 1) || !col.between?(0, seats[0].size - 1)
end

def get_new_state(seats, length, i, j)
  return FLOOR if seats[i][j] == FLOOR

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
    return EMPTY if (num_of_occupied_seats.positive? && seats[i][j] == EMPTY) ||
                    (num_of_occupied_seats >= 5 && seats[i][j] == OCCUPIED)
  end

  OCCUPIED
end

def arrange_seats(seats)
  length = [seats.size, seats[0].size].max
  prev = seats
  curr = []

  loop do
    curr = (0...prev.size).map do |i|
      (0...prev[i].size).map { |j| get_new_state(prev, length, i, j) }
    end

    return curr if prev == curr

    prev = curr.clone
  end
end

puts arrange_seats($stdin.each_line
                         .map { |line| line.chomp.split('') })
  .flatten
  .select { |c| c == OCCUPIED }
  .size
