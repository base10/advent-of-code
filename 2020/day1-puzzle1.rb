#!/usr/bin/env ruby

require 'pry-byebug'

INPUT = File.expand_path('day1-puzzle1-input.txt', __dir__)
TARGET = 2020

values = File.readlines(INPUT)
values.map!(&:chomp)
values.map!(&:to_i)

# binding.pry

values.each do |value|
  test_value = TARGET - value

  next unless values.include?(test_value)

  puts test_value * value
end
