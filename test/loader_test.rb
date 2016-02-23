require_relative './test_helper'
require 'letl/loader'

class LoadTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:params) { {:args=> {:dir=>"/tmp/data"}, :state=>[]} }
  let(:loader_object) { MiniTest::Mock.new.expect :load!, [Hash] }
  let(:loader) { MiniTest::Mock.new.expect :new, loader_object, [{:args=>{:dir=>"/tmp/data"}, :state=>{}}] }
  let(:loaders) { [{loader: loader}.merge(params)]}

  def test_load
    Tetl::Loader.new({}, loaders: loaders).load_each!
    loader.verify
    loader_object.verify
  end
end
