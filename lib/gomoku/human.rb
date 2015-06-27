require 'gomoku/player'

class Human < Player
  def human?
    true
  end

  def update
    # Update mouse hover location
    @hover_r = Utility.y_to_r(@window.mouse_y)
    @hover_c = Utility.x_to_c(@window.mouse_x)
  end

  def draw
    return unless Utility.in_range?(@hover_r, @hover_c) &&
                  @board.empty?(@hover_r, @hover_c)
    # Draw the hover for next piece
    @board.draw_stone(@color, @hover_r, @hover_c)
  end
end
