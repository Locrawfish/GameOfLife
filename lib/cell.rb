class Cell
  
  attr_reader :state

  def initialize(state)
    @state = state
  end

  def alive?
    @state == :alive
  end

  def make_alive
    @state = :alive
  end

  def dies(neighbors)
    return true if neighbors.between?(0,1) || neighbors > 3
  end

  def should_live?(neighbors)
    neighbor_count = alive_neighbor_count(neighbors)
    if @state == :alive
      if neighbor_count < 2
        false
      elsif neighbor_count > 3
        false
      else
        true
      end
    else @state = :dead
      if neighbor_count == 3
        true
      end
    end
  end

  def alive_neighbor_count(neighbors)
    neighbors.count { |neighbor| neighbor.state == :alive }
  end
end
# RULES 
# Any live cell with fewer than two live neighbours dies (referred to as underpopulation or exposure[1]).
# Any live cell with more than three live neighbours dies (referred to as overpopulation or overcrowding).
# Any live cell with two or three live neighbours lives, unchanged, to the next generation.
# Any dead cell with exactly three live neighbours will come to life.
