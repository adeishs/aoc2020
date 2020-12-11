#!/usr/bin/env ruby
# frozen_string_literal: true

EMPTY = 'L'
OCCUPIED = '#'
FLOOR = '.'
DIRS = [-1, 0, 1]

seat_rows = $stdin.each_line.map(&:chomp).to_a

prev = seat_rows.clone
length = [seat_rows.size, seat_rows[0].size].max
curr = []

loop do
  (0...seat_rows.size).each do |i|
    curr[i] = FLOOR * prev[i].size
    (0...prev[i].size).each do |j|
      case prev[i][j]
      when EMPTY
        occupied_seen = false
        DIRS.product(DIRS).reject { |y, x| x.zero? && y.zero? }.each do |y, x|
          (1..length).each do |dist|
            row = i + dist * y
            col = j + dist * x

            break if !row.between?(0, seat_rows.size - 1) ||
                     !col.between?(0, seat_rows[0].size - 1)
            next if prev[row][col] == FLOOR

            occupied_seen = prev[row][col] == OCCUPIED
            break
          end
          break if occupied_seen
        end
        curr[i][j] = occupied_seen ? EMPTY : OCCUPIED
      when OCCUPIED
        num_of_occupied_seats = 0
        DIRS.product(DIRS).reject { |y, x| x.zero? && y.zero? }.each do |y, x|
          (1..length).each do |dist|
            row = i + dist * y
            col = j + dist * x

            break if !row.between?(0, seat_rows.size - 1) ||
                     !col.between?(0, seat_rows[0].size - 1)
            next if prev[row][col] == FLOOR

            num_of_occupied_seats += 1 if prev[row][col] == OCCUPIED
            break
          end
        end

        curr[i][j] = num_of_occupied_seats >= 5 ? EMPTY : prev[i][j]
      else
        curr[i][j] = prev[i][j]
      end
    end
  end

  break if prev == curr

  prev = curr.clone
  curr = []
end

puts curr.map { |row| row.split('').select { |c| c == OCCUPIED }.size }
         .sum
