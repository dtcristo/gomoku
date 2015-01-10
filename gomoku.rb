require 'gosu'

class Gomoku < Gosu::Window
  def initialize
    super 800, 800, false
    self.caption = "Gomoku"

    # Setup sprites
    @grid = Gosu::Image.new(self, "assets/grid.png", true)
    @black = Gosu::Image.new(self, "assets/black.png", true)
    @white = Gosu::Image.new(self, "assets/white.png", true)

    # Default value in @state is invalid move (outside grid)
    @state = Hash.new(:invalid)

    # Setup blank spaces within grid range
    for r in (0..18)
      for c in (0..18)
        @state[[r,c]] = :empty
      end
    end

    # Black goes first
    @turn = :black

    # Setup flag to indicate a turn needs to be processed
    @process_turn = false
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::MsLeft
      # Get the location of the click
      click_r = y_to_r mouse_y
      click_c = x_to_c mouse_x

      # Check for black space
      if @state[[click_r, click_c]] == :empty
        # Perform move
        @state[[click_r, click_c]] = @turn
        # Update turn
        if @turn == :black
          @turn = :white
        else
          @turn = :black
        end

        # Update flag
        @process_turn = true
      end
    end
  end

  def button_up(id)
  end

  def update
    # Update mouse hover location
    @hover_r = y_to_r mouse_y
    @hover_c = x_to_c mouse_x

    # If a move has been made, process the turn
    if @process_turn
      # Loop through board cells and check winner, break when found
      catch :break do
        for r in (0..18)
          for c in (0..18)
            winner = check_winner r, c
            if winner != :none
              puts winner.to_s + " wins!"
              throw :break
            end
          end
        end
      end

      # Done processing, reset flag
      @process_turn = false
    end
  end

  def draw
    @grid.draw(0, 0, 0)

    # Loop through board cells and render stones
    for r in (0..18)
      for c in (0..18)
        stone = @state[[r,c]]
        case stone
        when :white
          @white.draw(c_to_x(c), r_to_y(r), 1)
        when :black
          @black.draw(c_to_x(c), r_to_y(r), 1)
        end
      end
    end

    # Draw the hover for next piece
    if @hover_r >= 0 and @hover_r <= 18 and
       @hover_c >= 0 and @hover_c <= 18 and
       @state[[@hover_r, @hover_c]] == :empty
      if @turn == :black
        @black.draw(c_to_x(@hover_c), r_to_y(@hover_r), 1)
      else
        @white.draw(c_to_x(@hover_c), r_to_y(@hover_r), 1)
      end
    end
  end

  def check_winner r, c
    current = @state[[r,c]]

    # No winner if we're on an empty cell
    if current == :empty
      return :none
    end

    # Test horizontal sequence
    if c < 15
      count = 0
      (0..4).each do |offset|
        if @state[[r, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return current
      end
    end

    # Test vertical sequence
    if r < 15
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return current
      end
    end

    # Test diagonal-up sequence
    if r > 3 and c < 15
      count = 0
      (0..4).each do |offset|
        if @state[[r-offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return current
      end
    end

    # Test diagonal-down sequence
    if r < 15 and c < 15
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return current
      end
    end

    # No winner
    return :none
  end

  # Helper methods
  def r_to_y r
    return r*40 + 20
  end

  def c_to_x c
    return c*40 + 20
  end

  def x_to_c x
    return (x.to_i - 20) / 40
  end

  def y_to_r y
    return (y.to_i - 20) / 40
  end
end

# Show the Gomoku window
Gomoku.new.show
