require 'test_helper'

class VerstionTest < Minitest::Test
  def test_version_exists
    refute_nil Gomoku::VERSION
  end
end
