module Gomoku
  # Human controlled player
  class Human < Player
    def human?
      true
    end

    def click(click_r, click_c)
      @click_r = click_r
      @click_c = click_c
    end

    def update
      # Update mouse hover location
      @hover_r = Utility.y_to_r(@window.mouse_y)
      @hover_c = Utility.x_to_c(@window.mouse_x)
    end

    def pick_move
      return unless @click_r && @click_c
      return unless @board.empty?(@click_r, @click_c)
      move_r = @click_r
      move_c = @click_c
      @click_r, @click_c = nil
      [move_r, move_c]
    end
  end
end
