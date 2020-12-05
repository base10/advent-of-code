#!/usr/bin/env ruby

require 'pry-byebug'

# FIXME: ARGV this
INPUT = File.expand_path('day3-input.txt', __dir__)

class Counter
  attr_accessor :open_count, :tree_count

  def initialize
    @open_count = 0
    @tree_count = 0
  end

  def classify(character)
    @open_count += 1 if character == '.'
    @tree_count += 1 if character == '#'
  end
end

# I need the first iteration to be line 1, Pos 3
class Iterator
  attr_accessor :iteration, :position, :steps

  def initialize(position:, steps: 3)
    @iteration = 0
    @position = position
    @steps = steps
  end

  def next_position
    @iteration += 1

    position.y = @iteration
    position.x = @iteration * steps
  end
end

class Position
  attr_accessor :x, :y

  def initialize(x: 0, y: 0)
    @x = x
    @y = y
  end
end

# Read the file
lines = File.readlines(INPUT)
steps = 3

# Prep the lines, initially
lines.map!(&:chomp)
max_position = lines.size * steps
max_width = (max_position / lines.first.size) + 1
lines.map! do |line|
  line * max_width
end

# Initialize position at 0, 0
counter = Counter.new
position = Position.new
iterator = Iterator.new(position: position)

until position.y == lines.size - 1
  iterator.next_position

  puts "Iteration: #{iterator.iteration}, x: #{position.x}, y: #{position.y}"

  line = lines[position.y]
  character = line[position.x]
  counter.classify(character)
end

puts "Trees: #{counter.tree_count}"
puts "Open: #{counter.open_count}"

# Determine position by length, wrap around
  # is there a modulo function?
    # There is, but what I want is the remainder, except that's not right
# either, I need to _wrap_ the function.
# Move right 3, down 1 line
  # until you are past the bottom of the map
  # Regenerate to the right as needed to complete the traversal
    # wrap around the array?
# . denote open spaces
# \# denotes trees
# 
# If a position is a tree, count it
  # This is something rotate() can do until the set is exhausted


# An alternate idea would be to determine how many lines there are in the file,
# determine how wide the run needs to be, then use the `*` operator on each line
# to get the required width (after determining the num of chars)
