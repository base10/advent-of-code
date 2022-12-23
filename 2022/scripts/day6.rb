#!/usr/bin/env ruby

require "pry-byebug"

class Day6
  attr_accessor :file_lines, :input_file, :marker_length, :marker_position

  def initialize(input_file:, marker_length:)
    @input_file = input_file
    @marker_length = marker_length
  end

  def run
    read_file
    find_marker
  end

  def report
    "#{marker_position}"
  end

  private

  def read_file
    @file_lines = File.readlines(input_file, chomp: true)
  end

  def find_marker
    offset = 0
    found = false

    message = file_lines.first
    max_test = message.size - (marker_length - 1)

    while !found && (offset < max_test) do
      @marker_position = offset + marker_length
      test_string = message.slice(offset, marker_length)

      if test_string.codepoints.uniq.size == marker_length
        found = true
      end

      offset += 1
    end
  end
end

input_file_name = ARGV.shift
input_file = File.path(
  Pathname.new(
    Dir.pwd + "/inputs/#{input_file_name}"
  )
)

puzzle1 = Day6.new(input_file: input_file, marker_length: 4)
puzzle1.run

puts "Puzzle 1: #{puzzle1.report}"

puzzle2 = Day6.new(input_file: input_file, marker_length: 14)
puzzle2.run

puts "Puzzle 2: #{puzzle2.report}"
