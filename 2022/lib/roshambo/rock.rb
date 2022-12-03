module Roshambo
  class Rock < Tool
    SHAPE_SCORE = 1

    RESULTS = {
      Roshambo::Paper => :lose,
      Roshambo::Rock => :tie,
      Roshambo::Scissors => :win
    }.freeze

    DESIRED_RESULTS = {
      tie: Roshambo::Rock,
      win: Roshambo::Paper,
      lose: Roshambo::Scissors
    }.freeze

    def class_for_desired_result(desired_result:)
      DESIRED_RESULTS.fetch(desired_result)
    end

    private

    def results_map
      RESULTS
    end

    def shape_score
      SHAPE_SCORE
    end
  end
end
