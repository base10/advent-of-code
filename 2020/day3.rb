#!/usr/bin/env ruby

require 'pry-byebug'
Dir["./lib/*.rb"].each { |file| require file }

# FIXME: ARGV this
INPUT = File.expand_path('./inputs/day3-input.txt', __dir__)


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
