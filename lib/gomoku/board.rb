module Gomoku
  # Defines the board state and rendering
  class Board
    attr_reader :state

    def initialize(window)
      # Setup sprites
      @grid = Gosu::Image.new(window, File.expand_path('../../../assets/grid.png', __FILE__), true)
      @black = Gosu::Image.new(window, File.expand_path('../../../assets/black.png', __FILE__), true)
      @white = Gosu::Image.new(window, File.expand_path('../../../assets/white.png', __FILE__), true)
    end

    def reset
      # Default value in @state is invalid move (outside grid)
      @state = Hash.new(:invalid)
      # Setup blank spaces within grid range
      each_r_c do |r, c|
        @state[[r, c]] = :empty
      end
    end

    def draw
      # Draw the empty grid
      @grid.draw(0, 0, 0)
      # Loop through board cells and render stones
      each_r_c do |r, c|
        color = @state[[r, c]]
        draw_stone(color, r, c)
      end
    end

    def draw_stone(color, r, c)
      case color
      when :black
        @black.draw(Utility.c_to_x(c), Utility.r_to_y(r), 1)
      when :white
        @white.draw(Utility.c_to_x(c), Utility.r_to_y(r), 1)
      end
    end

    def check_win(r, c)
      current = @state[[r, c]]

      # No winner if we're on an empty cell
      return :none if current == :empty

      # Test horizontal sequence
      if c < 16
        count = 0
        (0..4).each do |offset|
          if @state[[r, c + offset]] == current
            count += 1
          else break
          end
        end
        # Winner found
        return :horizontal if count == 5
      end

      # Test vertical sequence
      if r < 16
        count = 0
        (0..4).each do |offset|
          if @state[[r + offset, c]] == current
            count += 1
          else break
          end
        end
        # Winner found
        return :vertical if count == 5
      end

      # Test diagonal-up sequence
      if r > 4 && c < 16
        count = 0
        (0..4).each do |offset|
          if @state[[r - offset, c + offset]] == current
            count += 1
          else break
          end
        end
        # Winner found
        return :diagonal_up if count == 5
      end

      # Test diagonal-down sequence
      if r < 16 && c < 16
        count = 0
        (0..4).each do |offset|
          if @state[[r + offset, c + offset]] == current
            count += 1
          else break
          end
        end
        # Winner found
        return :diagonal_down if count == 5
      end

      # No winner
      :none
    end

    def empty?(r, c)
      state[[r, c]] == :empty
    end

    def self.each_r_c
      (1..19).each do |r|
        (1..19).each do |c|
          yield r, c
        end
      end
    end
  end
end
