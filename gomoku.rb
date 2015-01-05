require 'gosu'

class Gomoku < Gosu::Window
  def initialize
    super 800, 800, false
    self.caption = "Gomoku"

    @grid = Gosu::Image.new(self, "assets/grid.png", true)
    @black = Gosu::Image.new(self, "assets/black.png", true)
    @white = Gosu::Image.new(self, "assets/white.png", true)

    @state = Hash.new(:blank)

    @turn = :white
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::MsLeft
      click_x = (mouse_x.to_i - 20) / 40
      click_y = (mouse_y.to_i - 20) / 40
      # Check for black space
      if @state[[click_x, click_y]] == :blank
        # Perform move
        @state[[click_x, click_y]] = @turn
        # Update turn
        if @turn == :black
          @turn = :white
        else
          @turn = :black
        end
      end
    end
  end

  def button_up(id)
  end

  def update
    @hover_x = (mouse_x.to_i - 20) / 40
    @hover_y = (mouse_y.to_i - 20) / 40
  end

  def draw
    @grid.draw(0, 0, 0)

    # Loop through board cells and render stones
    for x in (0..18)
      for y in (0..18)
        stone = @state[[x,y]]
        case stone
        when :white
          @white.draw(x*40 + 20, y*40 + 20, 1)
        when :black
          @black.draw(x*40 + 20, y*40 + 20, 1)
        end
      end
    end

    # Draw the hover for next piece
    if @hover_x >= 0 and @hover_x < 19 and
       @hover_y >= 0 and @hover_y < 19 and
       @state[[@hover_x, @hover_y]] == :blank
      if @turn == :black
        @black.draw(@hover_x*40 + 20, @hover_y*40 + 20, 1)
      else
        @white.draw(@hover_x*40 + 20, @hover_y*40 + 20, 1)
      end
    end
  end
end

# Show the Gomoku window
Gomoku.new.show
