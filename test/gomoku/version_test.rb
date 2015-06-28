require 'test_helper'

# Test Version
class VersionTest < Minitest::Test
  def test_version_exists
    refute_nil Gomoku::VERSION
  end
end
