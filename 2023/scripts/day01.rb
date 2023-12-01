#!/usr/bin/env ruby

require "debug";
require "pathname";

DIGITS = /\d/
NUMBER_MAP = {
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9,

  "fiveight" => 58,
  "oneight" => 18,
  "twone" => 21,
  "eightwo" => 82,
  "eighthree" => 83,
  "sevenine" => 79,
  "nineight" => 98,
}

INVERSE_NUMBER_MAP = NUMBER_MAP.invert

input_file_name = "inputs/day01.txt"
input_file = File.path(Pathname.new(Dir.pwd + "/#{input_file_name}"))
reporter = []

file_handle = File.new(input_file)
file_handle.each_line do |line|
  digits = line.chars.select { |char| char.match?(DIGITS) }
  value = digits.first + digits.last
  reporter << value.to_i
end

puts "Puzzle 1"
puts reporter.sum

puts "****"

#input_file_name2 = "inputs/day01_sample2.txt"
input_file_name2 = input_file_name
input_file2 = File.path(Pathname.new(Dir.pwd + "/#{input_file_name2}"))
reporter2 = []

# index each number
# pick lowest
# substitute
# remap
# no matches, return the line
def remap_numbers(entry)
  scores = {}

  NUMBER_MAP.each_key do |key|
    score = entry.index(key)

    next if score.nil?

    if scores.has_key?(score)
      highest = [NUMBER_MAP[scores[score]], NUMBER_MAP[key]].sort.reverse.first
      scores[score] = INVERSE_NUMBER_MAP[highest]
    else
      scores[score] = key
    end
  end

  return entry if scores.empty?

  lowest = scores.keys.sort.first
  entry.sub!(scores[lowest], NUMBER_MAP[scores[lowest]].to_s)

  remap_numbers(entry)
end

file_handle = File.new(input_file2)
file_handle.each_line do |line|
  adjusted_line = remap_numbers(line.chomp)
  digits = adjusted_line.chars.select { |char| char.match?(/\d/) }
  value = digits.first + digits.last

    puts "#{line.chomp} | #{adjusted_line} | #{digits.join} | #{value}"

  reporter2 << value.to_i
end

puts "\nPuzzle 2"
puts reporter2.sum

# binding.break

