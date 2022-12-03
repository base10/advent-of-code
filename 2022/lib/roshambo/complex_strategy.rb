module Roshambo
  class ComplexStrategy
    attr_accessor(
      :class_object_map,
      :data,
      :input_file,
      :paper,
      :rock,
      :scissors,
      :strategy_map
    )

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
        x: :lose,
        y: :tie,
        z: :win
      }

      @class_object_map = {
        Roshambo::Paper => paper,
        Roshambo::Rock => rock,
        Roshambo::Scissors => scissors
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
        opponent_key, desired_result_key = line.chomp.split(" ")

        opponent_tool = strategy_map.fetch(strategy_key(opponent_key))
        desired_result = strategy_map.fetch(strategy_key(desired_result_key))

# binding.pry

        player_tool = tool_from_desired_result(
          desired_result: desired_result,
          opponent_tool: opponent_tool
        )

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

    def tool_from_desired_result(desired_result:, opponent_tool:)
      test_tool = class_object_map.fetch(opponent_tool)

      class_object_map.fetch(
        test_tool.class_for_desired_result(desired_result: desired_result)
      )
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
