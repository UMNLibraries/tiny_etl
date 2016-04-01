require_relative './test_helper'
require 'tiny_etl/loader'

class LoadTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:params) { {:args=> {:dir=>"/tmp/data"}, :state=>[]} }
  let(:loader_object) { MiniTest::Mock.new.expect :load!, [Hash] }
  let(:loader) { MiniTest::Mock.new.expect :new, loader_object, [{:args=>{:dir=>"/tmp/data"}, :state=>{}}] }
  let(:loaders) { [{loader: loader}.merge(params)]}

  def test_load
    TinyEtl::Loader.new({}, loaders: loaders).load_each!
    loader.verify
    loader_object.verify
  end

  def test_load_error
    err = assert_raises RuntimeError do
      TinyEtl::Loader.new({}, loaders: [{loader: Object}]).load_each!
    end
    expected = "An error occurred for loader \"Object\" with arguments \"\": wrong number of arguments (1 for 0)"
    assert_equal expected, err.message
  end
end
