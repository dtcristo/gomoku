require 'test_helper'

class BoardTest < Minitest::Test
  def test_each_r_c
    count = 0
    Gomoku::Board.each_r_c do |r, c|
      assert Gomoku::Utility.in_range?(r, c)
      count += 1
    end
    assert_equal 19 * 19, count
  end
end
