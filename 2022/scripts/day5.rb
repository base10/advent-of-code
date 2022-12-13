#!/usr/bin/env ruby

class Day5
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
    end
  end

  def puzzle1_report
    "Puzzle 1: …"
  end

  def puzzle2
    data = []
    file_lines.each do |line|
    end

    @puzzle2_result = { count: data.count }
  end

  def puzzle2_report
    "Puzzle 2: …"
  end
end

input_file_name = ARGV.shift
input_file = File.path(
  Pathname.new(
    Dir.pwd + "/inputs/#{input_file_name}"
  )
)

day5 = day5.new(input_file: input_file)

day5.run

puts day5.report
