require_relative './test_helper'
require 'tiny_etl/version'

class TinyEtlTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TinyEtl::VERSION
  end
end
