module Roshambo
  class Result
    attr_accessor :result, :round, :score

    def initialize(result:, score:, round: nil)
      @result = result
      @score = score
      @round = round
    end

    def summary
      "Round: #{round} – Result: #{result} - Score: #{score}"
    end

    def to_h
      { result: result, round: round, score: score }
    end
  end
end
