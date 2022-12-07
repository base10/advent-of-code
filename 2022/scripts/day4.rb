#!/usr/bin/env ruby

require "pry-byebug"

class Day4
  attr_accessor :file_lines, :input_file, :puzzle1_result, :puzzle2_result

  def initialize(input_file:)
    @input_file = input_file
  end

  def run
    read_file
    puzzle1
    puzzle2
  end

  def report
    [puzzle1_report, puzzle2_report].join("\n")
  end

  private

  def read_file
    @file_lines = File.readlines(input_file, chomp: true)
  end

  def puzzle1
    data = []
    file_lines.each do |line|
      tuple_a, tuple_b = line.split(",")

      range_a = tuple_to_range(tuple: tuple_a)
      range_b = tuple_to_range(tuple: tuple_b)

      range_array = [range_a, range_b]

      next unless range_contains_other?(ranges: range_array)

      data << range_array
    end

    @puzzle1_result = { count: data.count }
  end

  def puzzle1_report
    "Puzzle 1: Ranges containing the paired range: #{puzzle1_result[:count]}"
  end

  def puzzle2
    data = []
    file_lines.each do |line|
      tuple_a, tuple_b = line.split(",")

      range_a = tuple_to_range(tuple: tuple_a)
      range_b = tuple_to_range(tuple: tuple_b)

      array_a = range_a.to_a
      array_b = range_b.to_a

      next unless array_a.intersection(array_b).any?

      data << [array_a, array_b]
    end

    @puzzle2_result = { count: data.count }
  end

  def puzzle2_report
    "Puzzle 2: Ranges with overlap: #{puzzle2_result[:count]}"
  end

  def tuple_to_range(tuple:)
    a, b = tuple.split("-")

    (a.to_i..b.to_i)
  end

  def range_contains_other?(ranges:)
    range_a, range_b = ranges

    range_a.cover?(range_b) || range_b.cover?(range_a)
  end
end

input_file_name = ARGV.shift
input_file = File.path(Pathname.new(Dir.pwd + "/inputs/#{input_file_name}"))

day4 = Day4.new(input_file: input_file)

day4.run

puts day4.report
