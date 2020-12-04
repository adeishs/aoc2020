#!/usr/bin/env ruby
# frozen_string_literal: true

def valid_passport(passport)
  h = Hash[*passport.split(/[ :]/)]

  h.keys.count == 7 &&
  h['byr'].to_i.between?(1920, 2002) &&
  h['iyr'].to_i.between?(2010, 2020) &&
  h['eyr'].to_i.between?(2020, 2030) &&
  ((!h['hgt'].rindex('cm').nil? &&
    h['hgt'].sub('cm', '').to_i.between?(150, 193)) ||
   (!h['hgt'].rindex('in').nil? &&
    h['hgt'].sub('in', '').to_i.between?(59, 76))) &&
  h['hcl'].match(/^#[\da-f]{6}$/) &&
  %w[amb blu brn gry grn hzl oth].any? { |c| c == h['ecl'] } &&
  h['pid'].match(/^\d{9}$/)
end

puts $stdin.read
           .split("\n\n")
           .map { |line| valid_passport(line.gsub("\n", ' ')
                                            .gsub(/cid:\d+ ?/, '')) }
           .select { |valid| valid }
           .count
