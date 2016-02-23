require_relative '../test_helper'
require 'tiny_etl/reducers/json_transformer'

class ContentdmTest < Minitest::Test
  extend Minitest::Spec::DSL

  def test_state
    expected = '{"reducers":[{"blah":"blah"}],"data":[{"id":"123","title":"War and Peace"}]}'
    reducer = TinyEtl::JsonTransformer.new(state: {reducers: [{blah: 'blah'}], data: [{'id' => '123', 'title' => 'War and Peace'}]})
    assert_equal expected, reducer.state[:data]
    # It retains other portions of the state and passes them through
    assert_equal [{:blah=>"blah"}], reducer.state[:reducers]
  end
end
