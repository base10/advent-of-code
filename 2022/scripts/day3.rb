#!/usr/bin/env ruby

require "pry-byebug"

class Day3
  attr_accessor(
    :file_lines, :input_file, :priority, :puzzle1_result, :puzzle2_result
  )

  def initialize(input_file:)
    @input_file = input_file
    @priority = populate_priority
  end

  def run
    read_file
    process_puzzle1
    process_puzzle2
  end

  def report
    [
      report_puzzle1,
      report_puzzle2
    ].join("\n")
  end

  private

  def read_file
    @file_lines = File.readlines(input_file, chomp: true)
  end

  def process_puzzle1
    data = []
    file_lines.each do |line|
      knapsack_contents = line.chars
      first_pocket = knapsack_contents.shift(line.chomp.size / 2)
      common_item = first_pocket.intersection(knapsack_contents)

      data << priority.fetch(common_item.first)
    end

    @puzzle1_result = { count: data.count, score: data.sum }
  end

  def report_puzzle1
    "Puzzle 1: Total rucksacks: #{puzzle1_result[:count]} – " \
      "Total score: #{puzzle1_result[:score]}"
  end

  def process_puzzle2
    data = []

    until file_lines.empty?
      team_knapsacks = file_lines.shift(3)
      items = team_knapsacks.map(&:chars)

      common_item = items[0].intersection(items[1], items[2])

      data << priority.fetch(common_item.first)
    end

    @puzzle2_result = { count: data.count, score: data.sum }
  end

  def report_puzzle2
    "Puzzle 2: Total teams: #{puzzle2_result[:count]} - " \
      "Total score: #{puzzle2_result[:score]}"
  end

  def populate_priority
    letters = ('a'..'z').to_a + ('A'..'Z').to_a
    numbers = (1..52).to_a

    priority = letters.zip(numbers)
    priority.to_h
  end
end

input_file_name = ARGV.shift
input_file = File.path(Pathname.new(Dir.pwd + "/inputs/#{input_file_name}"))

day3 = Day3.new(input_file: input_file)

day3.run

puts day3.report
