#!/usr/bin/env crystal

depart_ts_str, id_str = STDIN.each_line.map { |line| line.chomp }.to_a

depart_ts = depart_ts_str.to_i64

ts_id = {} of Int64 => Int64
id_str.split(",")
  .reject { |t| t == "x" }
  .map { |t| t.to_i64 }
  .each do |id|
    ts_id[
      (depart_ts...depart_ts + id).select { |ts| (ts % id).zero? }
        .first,
    ] = id
  end

ts_min = ts_id.keys.min
puts ts_id[ts_min] * (ts_min - depart_ts)
