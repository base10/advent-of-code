module Roshambo
  class Scissors < Tool
    SHAPE_SCORE = 3

    RESULTS = {
      Roshambo::Paper => :win,
      Roshambo::Rock => :lose,
      Roshambo::Scissors => :tie
    }.freeze

    DESIRED_RESULTS = {
      tie: Roshambo::Scissors,
      win: Roshambo::Rock,
      lose: Roshambo::Paper
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
