#!/usr/bin/env ruby
# frozen_string_literal: true

EMPTY = 'L'
OCCUPIED = '#'
FLOOR = '.'

seat_rows = $stdin.each_line.map(&:chomp).to_a

prev = seat_rows.clone
curr = []

loop do
  (0...prev.size).each do |i|
    min_dy = i.zero? ? 0 : -1
    max_dy = i < prev.size - 1 ? 1 : 0

    curr[i] = EMPTY * prev[i].size
    (0...prev[i].size).each do |j|
      min_dx = j.zero? ? 0 : -1
      max_dx = j < prev[i].size - 1 ? 1 : 0
      case prev[i][j]
      when EMPTY
        occupied = false
        (min_dy..max_dy).each do |y|
          (min_dx..max_dx).each do |x|
            next if x.zero? && y.zero?

            if prev[i + y][j + x] == OCCUPIED
              occupied = true
              break
            end
          end
          break if occupied
        end
        curr[i][j] = OCCUPIED unless occupied
      when OCCUPIED
        num_of_occupied_seats = 0
        (min_dy..max_dy).each do |y|
          (min_dx..max_dx).each do |x|
            next if x.zero? && y.zero?

            num_of_occupied_seats += 1 if prev[i + y][j + x] == OCCUPIED
          end
        end

        curr[i][j] = num_of_occupied_seats >= 4 ? EMPTY : prev[i][j]
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
