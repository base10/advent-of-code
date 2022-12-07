#!/usr/bin/env ruby

require "pry-byebug"

class Day3
  attr_accessor :data, :input_file, :priority

  def initialize(input_file:)
    @input_file = input_file
    @data = []

    @priority = populate_priority
  end

  def run
    File.foreach(input_file) do |line|
      knapsack_contents = line.chomp.chars
      first_pocket = knapsack_contents.shift(line.chomp.size / 2)
      common_item = first_pocket.intersection(knapsack_contents)

      data << priority.fetch(common_item.first)
    end
  end

  def report
    "Total rucksacks: #{data.count} – Total score: #{total_score}"
  end

  def total_score
    data.sum
  end

  private

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
