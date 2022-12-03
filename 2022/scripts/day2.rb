#!/usr/bin/env ruby

require "pry-byebug"
require "zeitwerk"
require_relative "../lib/roshambo"

input_file_name = ARGV.shift
mode = ARGV.shift

input_file = File.path(Pathname.new(Dir.pwd + "/inputs/#{input_file_name}"))
klass = mode == "complex" ? Roshambo::ComplexStrategy : Roshambo::Strategy

strategy = klass.new(input_file: input_file)
strategy.run

strategy.report
