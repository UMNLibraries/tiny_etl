require_relative '../test_helper'
require 'tetl/reducers/json_transformer'

class ContentdmTest < Minitest::Test
  extend Minitest::Spec::DSL

  def test_state
    expected = '[{"id":"123","title":"War and Peace"}]'
    reducer = Tetl::JsonTransformer.new(state: {reducers: [{blah: 'blah'}], data: [{'id' => '123', 'title' => 'War and Peace'}]})
    assert_equal expected, reducer.state[:data]
    # It retains other portions of the state and passes them through
    assert_equal [{:blah=>"blah"}], reducer.state[:reducers]
  end
end
