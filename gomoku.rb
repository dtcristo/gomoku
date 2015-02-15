require 'gosu'
require_relative 'utility'
require_relative 'board'
require_relative 'human'
require_relative 'computer'

class Gomoku < Gosu::Window
  def initialize
    super 800, 800, false
    self.caption = "Gomoku"

    @board = Board.new(self)
    @black_player = Human.new(self, @board, :black)
    @white_player = Human.new(self, @board, :white)

    # Start a new game
    new_game
  end

  def new_game
    # Reset the board
    @board.reset

    # Black goes first
    @turn = :black

    # Setup flag to indicate a turn needs to be processed
    @process_turn = false

    @winner = false
  end

  def needs_cursor?
    true
  end

  def button_down id
    case id
    when Gosu::KbEscape
      close
    when Gosu::MsLeft
      # If no winner, attempt a move
      if !@winner
        # Get the location of the click
        click_r = Utility.y_to_r mouse_y
        click_c = Utility.x_to_c mouse_x

        # Check for black space
        if @board.state[[click_r, click_c]] == :empty
          # Perform move
          @board.state[[click_r, click_c]] = @turn
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

  def button_up id
  end

  def update
    case @turn
    when :black
      @black_player.update
    when :white
      @white_player.update
    end

    # If a move has been made, process the turn
    if @process_turn
      # Loop through board cells and check winner, break when found
      catch :break do
        for r in (1..19)
          for c in (1..19)
            win = @board.check_win r, c
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

  def draw
    @board.draw

    if !@winner
      case @turn
      when :black
        @black_player.draw
      when :white
        @white_player.draw
      end
    else
      # Winner, mark the winning sequence

      # Draw three adjacent 1px lines to make a single 3px line.
      # Worst code I ever wrote.
      case @winner_direction
      when :horizontal
        line_x1_1 = Utility.c_to_x(@winner_c)
        line_y1_1 = Utility.r_to_y(@winner_r) + 20
        line_x1_2 = Utility.c_to_x(@winner_c + 5)
        line_y1_2 = Utility.r_to_y(@winner_r) + 20

        line_x2_1 = line_x1_1
        line_y2_1 = line_y1_1 + 1
        line_x2_2 = line_x1_2
        line_y2_2 = line_y1_2 + 1

        line_x3_1 = line_x1_1
        line_y3_1 = line_y1_1 + 2
        line_x3_2 = line_x1_2
        line_y3_2 = line_y1_2 + 2
      when :vertical
        line_x1_1 = Utility.c_to_x(@winner_c) + 20
        line_y1_1 = Utility.r_to_y(@winner_r)
        line_x1_2 = Utility.c_to_x(@winner_c) + 20
        line_y1_2 = Utility.r_to_y(@winner_r + 5)

        line_x2_1 = line_x1_1 + 1
        line_y2_1 = line_y1_1
        line_x2_2 = line_x1_2 + 1
        line_y2_2 = line_y1_2

        line_x3_1 = line_x1_1 + 2
        line_y3_1 = line_y1_1
        line_x3_2 = line_x1_2 + 2
        line_y3_2 = line_y1_2
      when :diagonal_up
        line_x1_1 = Utility.c_to_x(@winner_c)
        line_y1_1 = Utility.r_to_y(@winner_r + 1)
        line_x1_2 = Utility.c_to_x(@winner_c + 5)
        line_y1_2 = Utility.r_to_y(@winner_r - 5)

        line_x2_1 = line_x1_1
        line_y2_1 = line_y1_1 + 1
        line_x2_2 = line_x1_2 + 1
        line_y2_2 = line_y1_2

        line_x3_1 = line_x1_1 + 1
        line_y3_1 = line_y1_1 + 1
        line_x3_2 = line_x1_2 + 1
        line_y3_2 = line_y1_2 + 1
      when :diagonal_down
        line_x1_1 = Utility.c_to_x(@winner_c)
        line_y1_1 = Utility.r_to_y(@winner_r)
        line_x1_2 = Utility.c_to_x(@winner_c + 5)
        line_y1_2 = Utility.r_to_y(@winner_r + 5)

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
end

# Show the Gomoku window
Gomoku.new.show
