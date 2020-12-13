#!/usr/bin/env ruby
# frozen_string_literal: true

(depart_ts_str, id_str) = $stdin.each_line.map(&:chomp)

depart_ts = depart_ts_str.to_i

ts_id = {}
id_str.split(',').reject { |t| t == 'x' }.map(&:to_i).each do |id|
  ts_id[
    (depart_ts...depart_ts + id).select { |ts| (ts % id).zero? }
                                .first
  ] = id
end

ts_min = ts_id.keys.min
puts ts_id[ts_min] * (ts_min - depart_ts)
