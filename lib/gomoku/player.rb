module Gomoku
  # Defines common functionality for all players
  class Player
    def initialize(window, board, color)
      @window = window
      @board = board
      @color = color
    end

    def click(_click_r, _click_c)
    end

    def update
    end

    def pick_move
    end

    def draw
      return unless @hover_r && @hover_c
      return unless Utility.in_range?(@hover_r, @hover_c) &&
                    @board.empty?(@hover_r, @hover_c)
      # Draw the hover for next piece
      @board.draw_hover(@color, @hover_r, @hover_c)
    end
  end
end
