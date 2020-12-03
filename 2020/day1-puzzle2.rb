#!/usr/bin/env ruby

require 'pry-byebug'

INPUT = File.expand_path('day1-puzzle1-input.txt', __dir__)
TARGET = 2020

values = File.readlines(INPUT)
values.map!(&:chomp)
values.map!(&:to_i)

binding.pry

values.each do |value|
  test_value_1 = TARGET - value
  test_array_1 = values.select { |entry| entry < test_value_1 }

  test_array_1.each do |value_2|
    test_value_2 = test_value_1 - value_2

    next unless test_array_1.include?(test_value_2)
    next unless (value + test_value_1 + test_value_2) == TARGET


    puts value * test_value_1 * test_value_2
  end
end
