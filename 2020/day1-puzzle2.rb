#!/usr/bin/env ruby

require 'pry-byebug'

INPUT = File.expand_path('day1-puzzle1-input.txt', __dir__)
TARGET = 2020

values = File.readlines(INPUT)
values.map!(&:chomp)
values.map!(&:to_i)

permutations = values.permutation(3).to_a
permutations.uniq! { |p| p.sum }
permutations.select! { |p| p.sum == TARGET }
permutations.flatten!
puts permutations.inject(&:*)
