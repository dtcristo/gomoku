require 'test_helper'

class VersionTest < Minitest::Test
  def test_version_exists
    refute_nil Gomoku::VERSION
  end
end
