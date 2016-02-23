require_relative './test_helper'
require 'letl/version'

class TetlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tetl::VERSION
  end
end
