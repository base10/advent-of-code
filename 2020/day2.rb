#!/usr/bin/ruby

require 'pry-byebug'

INPUT = File.expand_path('day2-input.txt', __dir__)

@valid_count_entries = []
@valid_position_entries = []

def validate_entry_by_count(entry)
  range, character, password = entry.split(/\ /)
  min, max = range.split(/-/)
  char_count = password.count(character)

  if min.to_i <= char_count && char_count  <= max.to_i
    @valid_count_entries << entry
  end
end

def validate_entry_by_position(entry)
  positions, character, password = entry.split(/\ /)
  character.chop!
  first, second = positions.split(/-/)

  first_match = password[first.to_i - 1] == character
  second_match = password[second.to_i - 1] == character

  if first_match ^ second_match
    @valid_position_entries << entry
  end
end

values = File.readlines(INPUT)

values.each do |entry|
  validate_entry_by_count(entry)
  validate_entry_by_position(entry)
end

puts "Valid by count: #{@valid_count_entries.count})"
puts "Valid by position: #{@valid_position_entries.count})"
