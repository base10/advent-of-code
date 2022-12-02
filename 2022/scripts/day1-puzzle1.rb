#!/usr/bin/env ruby

require "pry-byebug"

require_relative "../lib/calorie_parser.rb"
require_relative "../lib/elf.rb"

input_file_name = "inputs/day1_sample.txt"
input_file = File.path(Pathname.new(Dir.pwd + "/#{input_file_name}"))

# Init the parser object
# Run the parser object
# TBD: Handing back the results from parser and directing those into objects
# from there, or doing that work _in_ the parser
# This is potentially a thing I would love to use some functional techniques
# for

parser = CalorieParser.new(input_file: input_file)
parser.run

parser.results.each do |result|
  elf = Elf.new(calories: result)

  puts elf.total
end
