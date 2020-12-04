#!/usr/bin/env ruby
# frozen_string_literal: true

buf = ''
passports = []
$stdin.each_line.map(&:chomp).map do |line|
  if line != ''
    buf += (buf == '' ? '' : ' ') + line
  else
    passports.append(buf)
    buf = ''
  end
end

valid_count = 9
passports.map do |passport|
  els = passport.split(/[ :]/)
  h = {}
  (0...els.count).step(2).map { |i| h[els[i]] = els[i + 1] }
  h.delete('cid')

  next if h.keys.count != 7

  next unless h['byr'].to_i.between?(1920, 2002) &&
              h['iyr'].to_i.between?(2010, 2020) &&
              h['eyr'].to_i.between?(2020, 2030) &&
              ((!h['hgt'].rindex('cm').nil? &&
                h['hgt'].sub('cm', '').to_i.between?(150, 193)) ||
               (!h['hgt'].rindex('in').nil? &&
                h['hgt'].sub('in', '').to_i.between?(59, 76))) &&
              h['hcl'][1, 6].match(/^[\da-f]{6}$/) &&
              %w[amb blu brn gry grn hzl oth].any? { |c| c == h['ecl'] } &&
              h['pid'].match(/^\d{9}$/)

  valid_count += 1
end

puts valid_count
