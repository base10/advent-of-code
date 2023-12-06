#/usr/bin/env ruby

require "debug";
require "pathname";

# parse config, "possible game"
# read file line at a time, setting up game, rounds
# tell config about each game
# bail at first round that fails
# record game number of possible games
# sum the possible games

class Config
  attr_accessor :blue, :green, :red
  attr_reader :config_line

  def initialize(config_file)
    @config_file = config_file
    @config_line = File.readlines(@config_file).first.chomp
  end

  def parse
    segments = config_line.split(',')
    segments.each do |segment|
      num, color = segment.split(' ')

      color_method = color + '='

      self.send(color_method.to_sym, num.to_i)
    end
  end
end

class Game
  attr_reader :config, :game_line, :number
  attr_accessor :possible, :rounds, :min_blue, :min_green, :min_red

  def initialize(config:, game_line:)
    @config = config
    @game_line = game_line
    @possible = true
    @rounds = []

    game_number, rounds_text = game_line.split(':')

    parse_game_number(game_number)
    parse_rounds(rounds_text)
  end

  def play
    rounds.each do |round|
      @possible = round.validate
    end
  end

  def calc_min_value_to_possible
    methods = [:blue, :green, :red]
    rounds.each do |round|
      methods.each { |method| set_or_keep(method: method, round: round) }
    end
  end

  def possible?
    @possible
  end

  def power
    min_blue * min_green * min_red
  rescue TypeError => e
    puts "Failure in Game: #{number}"
    raise e
  end

  private

  def parse_game_number(game_number)
    _, raw_number = game_number.split(' ')
    @number = raw_number.to_i
  end

  def parse_rounds(rounds_text)
    round_segments = rounds_text.split(';')
    round_segments.each do |segment|
      rounds << Round.new(config: config, round_text: segment)
    end
  end

  def set_or_keep(method:, round:)
    comp_method = "min_#{method}".to_sym
    setter = "#{comp_method}=".to_sym

    return if round.public_send(method).nil?

    if public_send(comp_method).nil?
      public_send(setter, round.public_send(method))
    elsif public_send(comp_method) < round.public_send(method)
      public_send(setter, round.public_send(method))
    end
  end

  class Round
    attr_accessor :blue, :green, :red
    attr_reader :config, :round_text

    def initialize(config:, round_text:)
      @config = config
      @round_text = round_text
    end

    def validate
      parse
      compare
    end

    private

    def compare
      [:red, :green, :blue].each do |method|
        next if public_send(method).nil?
        return false if config.public_send(method) < public_send(method)
      end

      true
    end

    def parse
      segments = round_text.split(',')
      segments.each do |segment|
        segment.sub!(/^\ /,'')
        num, color = segment.split(' ')

        color_method = color + '='

        self.send(color_method.to_sym, num.to_i)
      end
    end
  end
end

input_file_name = "inputs/day02.txt"
input_file = File.path(Pathname.new(Dir.pwd + "/#{input_file_name}"))

config_file_name = "inputs/day02_p1_config.txt"
config_file = File.path(Pathname.new(Dir.pwd + "/#{config_file_name}"))

config = Config.new(config_file)
config.parse

possible_games = []
game_powers = []

file_handle = File.new(input_file)
file_handle.each_line do |line|
  game = Game.new(config: config, game_line: line.chomp)
  game.play

  if game.possible?
    possible_games << game.number
  end

  game.calc_min_value_to_possible
  game_powers << game.power
end

puts "Sum of possible games: #{possible_games.sum}"
puts "Power of all games: #{game_powers.sum}"
