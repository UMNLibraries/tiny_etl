require_relative './test_helper'
require 'tiny_etl/reducer'

class ReducerTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:reducer_object) { MiniTest::Mock.new.expect :state, [Hash] }
  let(:reducer) { MiniTest::Mock.new.expect :new, reducer_object, [{:args=>{:uri=>"http://example.com"}, :state=>[]}] }
  let(:reducers) { [{reducer: reducer, args: {uri: 'http://example.com'}}] }

  def test_extractions
    TinyEtl::Reducer.new(reducers: reducers).reduce
    reducer.verify
    reducer_object.verify
  end

  def test_reduce_error
    err = assert_raises RuntimeError do
      TinyEtl::Reducer.new(reducers: [{reducer: Object}]).reduce
    end
    expected = "An error occurred for reducer \"Object\" with arguments \"\": wrong number of arguments (1 for 0)"
    assert_equal expected, err.message
  end
end
