class Counter
  attr_accessor :open_count, :tree_count

  def initialize
    @open_count = 0
    @tree_count = 0
  end

  def classify(character)
    @open_count += 1 if character == '.'
    @tree_count += 1 if character == '#'
  end
end
