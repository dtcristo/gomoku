require 'test_helper'

class UtilityTest < Minitest::Test
  def test_in_range_when_in_range
    assert Gomoku::Utility.in_range?(1, 1)
    assert Gomoku::Utility.in_range?(10, 10)
    assert Gomoku::Utility.in_range?(19, 19)
  end

  def test_in_range_when_not_in_range
    refute Gomoku::Utility.in_range?(-1, 0)
    refute Gomoku::Utility.in_range?(10, 20)
    refute Gomoku::Utility.in_range?(-19, -19)
  end

  def test_toggle_color_when_black
    result = Gomoku::Utility.toggle_color(:black)
    assert_equal :white, result
  end

  def test_toggle_color_when_white
    result = Gomoku::Utility.toggle_color(:white)
    assert_equal :black, result
  end
end
