module Roshambo
  class Strategy
    attr_accessor :data, :input_file, :paper, :rock, :scissors, :strategy_map

    def initialize(input_file:)
      @input_file = input_file
      @data = []

      @paper = Paper.new
      @rock = Rock.new
      @scissors = Scissors.new

      @strategy_map = {
        a: Rock,
        b: Paper,
        c: Scissors,
        x: rock,
        y: paper,
        z: scissors
      }
    end

    def run
      puts "Reading #{input_file}"

      read_input_file
    end

    def report
      data.each { |result| puts result.summary }

      puts "Total score: #{total_score}"
    end

    private

    def read_input_file
      round = 1
      File.foreach(input_file) do |line|
        opponent_key, player_key = line.chomp.split(" ")

        opponent_tool = strategy_map.fetch(strategy_key(opponent_key))
        player_tool = strategy_map.fetch(strategy_key(player_key))

        player_tool.play(opponent: opponent_tool)
        result = Result.new(
          result: player_tool.result,
          round: round,
          score: player_tool.score
        )

        data << result
        round += 1
      end
    end

    def strategy_key(key)
      key.downcase.to_sym
    end

    def total_score
      scores = data.map(&:score)
      scores.sum
    end
  end
end
