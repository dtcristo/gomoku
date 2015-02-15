require_relative 'player'

class Human < Player
  def is_human?
    true
  end

  def update
    # Update mouse hover location
    @hover_r = Utility.y_to_r @window.mouse_y
    @hover_c = Utility.x_to_c @window.mouse_x
  end

  def draw
    # Draw the hover for next piece
    if Utility.in_range?(@hover_r, @hover_c) and @board.is_empty?(@hover_r, @hover_c)
      @board.draw_stone @color, @hover_r, @hover_c
    end
  end
end
