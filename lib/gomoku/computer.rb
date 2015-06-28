module Gomoku
  # Computer controlled player
  class Computer < Player
    def human?
      false
    end

    def update
      Board.each_r_c do |r, c|
        if @board.state[[r, c]] == :empty
          @board.state[[r, c]] = @window.turn
          # Update turn
          @window.turn = Utility.toggle_color(@window.turn)
          # Update flag
          @window.done_turn = true
          break
        end
      end
    end
  end
end
