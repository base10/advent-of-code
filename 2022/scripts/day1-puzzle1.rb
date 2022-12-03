#!/usr/bin/env ruby

require "pry-byebug"

require_relative "../lib/calorie_parser.rb"
require_relative "../lib/elf.rb"

input_file_name = "inputs/day1_puzzle1.txt"
input_file = File.path(Pathname.new(Dir.pwd + "/#{input_file_name}"))

# Init the parser object
# Run the parser object
# TBD: Handing back the results from parser and directing those into objects
# from there, or doing that work _in_ the parser
# This is potentially a thing I would love to use some functional techniques
# for

parser = CalorieParser.new(input_file: input_file)
parser.run

totals = []
parser.results.each do |result|
  count = parser.results.index(result) + 1
  elf = Elf.new(calories: result)

  totals << elf.total

  puts "#{count}: #{elf.total}"
end

puts "Max calories: #{totals.max}"

## Part II

sorted_totals = totals.sort.reverse
top_sorted_totals = sorted_totals[0..2]

puts "Sorted totals: #{p top_sorted_totals}"
puts "Top three calorie total: #{top_sorted_totals.sum}"
