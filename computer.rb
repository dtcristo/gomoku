require_relative 'player'

class Computer < Player
  def is_human?
    false
  end

  def update
    catch :break do
      for r in (1..19)
        for c in (1..19)

          if @board.state[[r,c]] == :empty

            @board.state[[r,c]] = @window.turn
            # Update turn
            if @window.turn == :black
              @window.turn = :white
            else
              @window.turn = :black
            end

            # Update flag
            @window.process_turn = true

            throw :break
          end
        end
      end
    end
  end
end
