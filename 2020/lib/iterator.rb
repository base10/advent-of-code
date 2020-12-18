class Iterator
  attr_accessor :iteration, :position, :steps

  def initialize(position:, steps: 3)
    @iteration = 0
    @position = position
    @steps = steps
  end

  def next_position
    @iteration += 1

    position.y = @iteration
    position.x = @iteration * steps
  end
end
