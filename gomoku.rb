require 'gosu'

class Gomoku < Gosu::Window
  def initialize
    super 800, 800, false
    self.caption = "Gomoku"

    # Setup sprites
    @grid = Gosu::Image.new(self, "assets/grid.png", true)
    @black = Gosu::Image.new(self, "assets/black.png", true)
    @white = Gosu::Image.new(self, "assets/white.png", true)

    # Start a new game
    new_game
  end

  def new_game
    # Default value in @state is invalid move (outside grid)
    @state = Hash.new(:invalid)

    # Setup blank spaces within grid range
    for r in (1..19)
      for c in (1..19)
        @state[[r,c]] = :empty
      end
    end

    # Black goes first
    @turn = :black

    # Setup flag to indicate a turn needs to be processed
    @process_turn = false

    @winner = false
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::KbEscape
      close
    when Gosu::MsLeft
      # If no winner, attempt a move
      if !@winner
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
      else
        # We already have a winner, so start new game
        new_game
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
        for r in (1..19)
          for c in (1..19)
            win = check_win r, c
            if win != :none
              @winner = true
              @winner_direction = win
              @winner_r = r
              @winner_c = c
              throw :break
            end
          end
        end
      end

      # Done processing, reset flag
      @process_turn = false
    end
  end

  def check_win r, c
    current = @state[[r,c]]

    # No winner if we're on an empty cell
    if current == :empty
      return :none
    end

    # Test horizontal sequence
    if c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :horizontal
      end
    end

    # Test vertical sequence
    if r < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :vertical
      end
    end

    # Test diagonal-up sequence
    if r > 4 and c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r-offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :diagonal_up
      end
    end

    # Test diagonal-down sequence
    if r < 16 and c < 16
      count = 0
      (0..4).each do |offset|
        if @state[[r+offset, c+offset]] == current
          count += 1
        else break
        end
      end
      # Winner found
      if count == 5
        return :diagonal_down
      end
    end

    # No winner
    return :none
  end

  def draw
    # Draw the empty grid
    @grid.draw(0, 0, 0)

    # Loop through board cells and render stones
    for r in (1..19)
      for c in (1..19)
        stone = @state[[r,c]]
        case stone
        when :white
          @white.draw(c_to_x(c), r_to_y(r), 1)
        when :black
          @black.draw(c_to_x(c), r_to_y(r), 1)
        end
      end
    end

    if !@winner
      # No winner, draw the hover for next piece
      if @hover_r >= 1 and @hover_r <= 19 and
         @hover_c >= 1 and @hover_c <= 19 and
         @state[[@hover_r, @hover_c]] == :empty
        if @turn == :black
          @black.draw(c_to_x(@hover_c), r_to_y(@hover_r), 1)
        else
          @white.draw(c_to_x(@hover_c), r_to_y(@hover_r), 1)
        end
      end
    else
      # Winner, mark the winning sequence

      # Draw three adjacent 1px lines to make a single 3px line.
      # Worst code I ever wrote.
      case @winner_direction
      when :horizontal
        line_x1_1 = c_to_x(@winner_c)
        line_y1_1 = r_to_y(@winner_r) + 20
        line_x1_2 = c_to_x(@winner_c + 5)
        line_y1_2 = r_to_y(@winner_r) + 20

        line_x2_1 = line_x1_1
        line_y2_1 = line_y1_1 + 1
        line_x2_2 = line_x1_2
        line_y2_2 = line_y1_2 + 1

        line_x3_1 = line_x1_1
        line_y3_1 = line_y1_1 + 2
        line_x3_2 = line_x1_2
        line_y3_2 = line_y1_2 + 2
      when :vertical
        line_x1_1 = c_to_x(@winner_c) + 20
        line_y1_1 = r_to_y(@winner_r)
        line_x1_2 = c_to_x(@winner_c) + 20
        line_y1_2 = r_to_y(@winner_r + 5)

        line_x2_1 = line_x1_1 + 1
        line_y2_1 = line_y1_1
        line_x2_2 = line_x1_2 + 1
        line_y2_2 = line_y1_2

        line_x3_1 = line_x1_1 + 2
        line_y3_1 = line_y1_1
        line_x3_2 = line_x1_2 + 2
        line_y3_2 = line_y1_2
      when :diagonal_up
        line_x1_1 = c_to_x(@winner_c)
        line_y1_1 = r_to_y(@winner_r + 1)
        line_x1_2 = c_to_x(@winner_c + 5)
        line_y1_2 = r_to_y(@winner_r - 5)

        line_x2_1 = line_x1_1
        line_y2_1 = line_y1_1 + 1
        line_x2_2 = line_x1_2 + 1
        line_y2_2 = line_y1_2

        line_x3_1 = line_x1_1 + 1
        line_y3_1 = line_y1_1 + 1
        line_x3_2 = line_x1_2 + 1
        line_y3_2 = line_y1_2 + 1
      when :diagonal_down
        line_x1_1 = c_to_x(@winner_c)
        line_y1_1 = r_to_y(@winner_r)
        line_x1_2 = c_to_x(@winner_c + 5)
        line_y1_2 = r_to_y(@winner_r + 5)

        line_x2_1 = line_x1_1 + 1
        line_y2_1 = line_y1_1
        line_x2_2 = line_x1_2
        line_y2_2 = line_y1_2 - 1

        line_x3_1 = line_x1_1
        line_y3_1 = line_y1_1 + 1
        line_x3_2 = line_x1_2 - 1
        line_y3_2 = line_y1_2
      end

      # Render the three lines
      draw_line(line_x1_1, line_y1_1, Gosu::Color.argb(0xffff0000), line_x1_2, line_y1_2, Gosu::Color.argb(0xffff0000), 2, :default)
      draw_line(line_x2_1, line_y2_1, Gosu::Color.argb(0xffff0000), line_x2_2, line_y2_2, Gosu::Color.argb(0xffff0000), 2, :default)
      draw_line(line_x3_1, line_y3_1, Gosu::Color.argb(0xffff0000), line_x3_2, line_y3_2, Gosu::Color.argb(0xffff0000), 2, :default)
    end
  end

  # Helper methods
  def r_to_y r
    return r*40 - 20
  end

  def c_to_x c
    return c*40 - 20
  end

  def x_to_c x
    return (x.to_i + 20) / 40
  end

  def y_to_r y
    return (y.to_i + 20) / 40
  end
end

# Show the Gomoku window
Gomoku.new.show
