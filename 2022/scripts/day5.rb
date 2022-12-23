#!/usr/bin/env ruby

require "pry-byebug"

class Day5
  attr_accessor(
    :file_lines,
    :input_file,
    :movement_lines,
    :puzzle1_result,
    :puzzle2_result,
    :stack_lines,
    :stack_state
  )

  def initialize(input_file:)
    @input_file = input_file
    @stack_state = {}
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

    segment_lines
    build_initial_stack_state
    process_move_instructions
  end

  def puzzle1_report
    result = stack_state.values.map(&:first)

    "Puzzle 1: #{result.join}"
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

  def segment_lines
    separator = file_lines.index("")

    puts "Seperator line: #{separator}"

    @stack_lines = file_lines[0, separator]
    @movement_lines = file_lines[(separator + 1), file_lines.size]
  end

  # TODO: refactor
  def build_initial_stack_state
    # Determine num of stacks and their positions in the line
    # start from end of stack lines
    # Find the slots with numbers, determine their spot, add them to the
    # position map

    position_line = stack_lines.pop
    position_chars = position_line.chars

    stack_position_map = {}
    stack_position_index = 1

    position_chars.each do |char|
      next unless char =~ /\d/

      stack_position_map[position_chars.index(char)] = stack_position_index
      stack_position_index += 1
    end

    stack_positions = stack_position_map.keys

    stack_position_map.values.each do |i|
      stack_state[i] = []
    end

    stack_lines.each do |line|
      line_chars = line.chars
      stack_positions.each do |position|
        next unless line_chars[position].match(/\w/)

        stack_state[stack_position_map[position]] << line_chars[position]
      end
    end
  end

  def process_move_instructions
    movement_lines.each do |line|
      matcher = /^move (\d+) from (\d+) to (\d+)/
      matches = line.match(matcher)

      count = matches[1].to_i
      source = matches[2].to_i
      destination = matches[3].to_i

      act_on_stack(count: count, destination: destination, source: source)
    end
  end

  def act_on_stack(count:, destination:, source:)
    count.times do
      stack_state[destination].unshift stack_state[source].shift
    end
  end
end

input_file_name = ARGV.shift
input_file = File.path(
  Pathname.new(
    Dir.pwd + "/inputs/#{input_file_name}"
  )
)

day5 = Day5.new(input_file: input_file)

day5.run

puts day5.report
