#!/usr/bin/env crystal

def between?(min : Int32, val : Int32, max : Int32)
  min <= val && val <= max
end

def valid_passport(passport)
  h = {} of String => String
  passport.split.map { |key_val|
    key, val = key_val.split(':')
    h[key] = val
  }

  h.keys.size == 7 &&
    between?(1920, h["byr"].to_i32, 2002) &&
    between?(2010, h["iyr"].to_i32, 2020) &&
    between?(2020, h["eyr"].to_i32, 2030) &&
    ((!h["hgt"].rindex("cm").nil? &&
      between?(150, h["hgt"].sub("cm", "").to_i32, 193)) ||
      (!h["hgt"].rindex("in").nil? &&
        between?(59, h["hgt"].sub("in", "").to_i32, 76))) &&
    h["hcl"].match(/^#[\da-f]{6}$/) &&
    %w[amb blu brn gry grn hzl oth].any? { |c| c == h["ecl"] } &&
    h["pid"].match(/^\d{9}$/)
end

puts STDIN.gets_to_end
  .split("\n\n")
  .select { |line|
    valid_passport(line.gsub("\n", ' ')
      .gsub(/cid:\d+ ?/, ""))
  }
  .size
