require 'gosu'
require 'gomoku/utility'

class Board
  attr_reader :state

  def initialize window
    # Setup sprites
    @grid = Gosu::Image.new(window, File.expand_path('../../../assets/grid.png', __FILE__), true)
    @black = Gosu::Image.new(window, File.expand_path('../../../assets/black.png', __FILE__), true)
    @white = Gosu::Image.new(window, File.expand_path('../../../assets/white.png', __FILE__), true)
  end

  def reset
    # Default value in @state is invalid move (outside grid)
    @state = Hash.new(:invalid)

    # Setup blank spaces within grid range
    for r in (1..19)
      for c in (1..19)
        @state[[r,c]] = :empty
      end
    end
  end

  def draw
    # Draw the empty grid
    @grid.draw(0, 0, 0)

    # Loop through board cells and render stones
    for r in (1..19)
      for c in (1..19)
        color = @state[[r,c]]
        draw_stone color, r, c
      end
    end
  end

  def draw_stone color, r, c
    case color
    when :black
      @black.draw(Utility.c_to_x(c), Utility.r_to_y(r), 1)
    when :white
      @white.draw(Utility.c_to_x(c), Utility.r_to_y(r), 1)
    end
  end

  def check_win r, c
    current = @state[[r,c]]

    # No winner if we're on an empty cell
    if current == :empty
      return :none
    end

    # Test horizontal sequence
    if c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :horizontal
      end
    end

    # Test vertical sequence
    if r < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :vertical
      end
    end

    # Test diagonal-up sequence
    if r > 4 and c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r-offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :diagonal_up
      end
    end

    # Test diagonal-down sequence
    if r < 16 and c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :diagonal_down
      end
    end

    # No winner
    return :none
  end

  def is_empty? r, c
    state[[r, c]] == :empty
  end
end
