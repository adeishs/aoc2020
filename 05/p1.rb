#!/usr/bin/env ruby
# frozen_string_literal: true

puts $stdin.each_line
           .map { |pass| pass.tr("BRFL", "1100").to_i(2) }
           .max
