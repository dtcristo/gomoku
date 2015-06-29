module Gomoku
  # Computer controlled player
  class Computer < Player
    def human?
      false
    end

    def pick_move
      @hover_r ||= 1
      @hover_c ||= 1

      # Test position and maybe return move here

      # Update hover location
      hover_next

      # return unless @hover_r && @hover_r
      # return unless @board.empty?(@hover_r, @hover_r)
      # return unless @hover_r >= 10 && @hover_c >= 10
      # move_r = @hover_r
      # move_c = @hover_c
      # @hover_r, @hover_c = 1
      # [move_r, move_c]
    end

    def hover_next
      r = @hover_r
      c = @hover_c
      while r <= 19 && c <= 19
        if c < 19
          c += 1
        else
          r += 1
          c = 1
        end
        if @board.empty?(r, c)
          @hover_r = r
          @hover_c = c
          return
        end
      end
    end
  end
end
