require 'test_helper'

class UtilityTest < Minitest::Test
  def test_in_range_when_in_range
    assert Utility.in_range?(1, 1)
    assert Utility.in_range?(10, 10)
    assert Utility.in_range?(19, 19)
  end

  def test_in_range_when_not_in_range
    refute Utility.in_range?(-1, 0)
    refute Utility.in_range?(10, 20)
    refute Utility.in_range?(-19, -19)
  end
end
