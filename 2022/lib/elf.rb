class Elf
  attr_accessor :calories

  def initialize(calories:)
    @calories = calories
  end

  # TODO: Items: count of entries in calories

  def total
    converted_calories = calories.map(&:to_i)

    converted_calories.sum
  end
end
