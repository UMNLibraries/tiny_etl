require 'test_helper'
require 'letl/version'

class LetlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Letl::VERSION
  end
end
