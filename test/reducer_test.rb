require_relative './test_helper'
require 'tetl/reducer'

class ReducerTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:reducer_object) { MiniTest::Mock.new.expect :state, [Hash] }
  let(:reducer) { MiniTest::Mock.new.expect :new, reducer_object, [{:args=>{:uri=>"http://example.com"}, :state=>[]}] }
  let(:reducers) { [{reducer: reducer, args: {uri: 'http://example.com'}}] }

  def test_extractions
    Tetl::Reducer.new(reducers: reducers).reduce
    reducer.verify
    reducer_object.verify
  end
end
