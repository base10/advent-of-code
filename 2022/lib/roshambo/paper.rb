module Roshambo
  class Paper < Tool
    SHAPE_SCORE = 2

    RESULTS = {
      Roshambo::Paper => :tie,
      Roshambo::Rock => :win,
      Roshambo::Scissors => :lose
    }.freeze

    DESIRED_RESULTS = {
      tie: Roshambo::Paper,
      win: Roshambo::Scissors,
      lose: Roshambo::Rock
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
