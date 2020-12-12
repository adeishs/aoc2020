#!/usr/bin/env crystal

EMPTY    = "L"
OCCUPIED = "#"
FLOOR    = "."
DS       = [-1, 0, 1]
DIRS     = DS.product(DS).reject { |y, x| x.zero? && y.zero? }

def outside_boundary?(row, col, seats)
  row < 0 || col < 0 || row >= seats.size || col >= seats[0].size
end

def get_new_state(seats, i, j)
  return FLOOR if seats[i][j] == FLOOR

  num_of_occupied_seats = 0
  DIRS.each do |y, x|
    row = i + y
    col = j + x

    next if outside_boundary?(row, col, seats) || seats[row][col] == FLOOR

    num_of_occupied_seats += 1 if seats[row][col] == OCCUPIED
    return EMPTY if (num_of_occupied_seats > 0 && seats[i][j] == EMPTY) ||
                    (num_of_occupied_seats >= 4 && seats[i][j] == OCCUPIED)
  end

  OCCUPIED
end

def arrange_seats(seats)
  prev = seats.to_a
  curr = [] of Char

  loop do
    curr = (0...prev.size).map do |i|
      (0...prev[i].size).map { |j| get_new_state(prev, i, j) }
    end

    return curr if prev == curr

    prev = curr.clone
  end
end

puts arrange_seats(STDIN.each_line.map { |line| line.chomp.split("") })
  .flatten
  .select { |c| c == OCCUPIED }
  .size
