class Cell
  attr_reader :state
  attr_accessor :neighbors

  def initialize(state, neighbors)
    @state = state
    @neighbors = neighbors
  end

  def alive?
    @state == :alive
  end

  def revive
    @state = :alive
  end

  def should_live?
    alive_neighbor_count.between?(2, 3) ? true : false
  end

  def alive_neighbor_count
    neighbors.count(&:alive?)
  end
end
# RULES
# Any live cell with fewer than two live neighbours dies (referred to as underpopulation or exposure[1]).
# Any live cell with more than three live neighbours dies (referred to as overpopulation or overcrowding).
# Any live cell with two or three live neighbours lives, unchanged, to the next generation.
# Any dead cell with exactly three live neighbours will come to life.
