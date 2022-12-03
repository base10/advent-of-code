module Roshambo
  class Tool
    attr_reader :opponent, :result, :score

    def initialize
    end

    def play(opponent:)
      @opponent = opponent
      @result = results_map.fetch(opponent)

      calculate_score
    end

    def class_for_desired_result(desired_result:)
      results_map.invert.fetch(desired_result)
    end

    def result_data
      { result: result, score: score }
    end

    private

    def results_map
      {}
    end

    def calculate_score
      @score = send(score_method) + shape_score
    end

    def score_method
      "#{result.to_s}_score"
    end

    def lose_score
      0
    end

    def shape_score
      0
    end

    def tie_score
      3
    end

    def win_score
      6
    end
  end
end
