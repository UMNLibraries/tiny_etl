require_relative './test_helper'
require 'tiny_etl/profile'
require 'tiny_etl/ingest'

class TestReducer
  attr_accessor :args, :second_pass
  def initialize(args: {}, state: {})
    @args = args
    @second_pass = args.fetch(:second_pass, false)
  end

  def state
    {reducers: reducers, stop: second_pass}
  end

  def reducers
    [{reducer: TestReducer, args: args.merge({second_pass: true})}]
  end
end


class IngestTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:mock_profile_object) do
    p = Minitest::Mock.new
    p.expect :replace_components, [{reducer: 'OaiThing', args: 'Blergh'}], [{:reducers=>[], :loaders=>[]}]
    p.expect :reducers, []
    p.expect :loaders, []
  end
  let(:mock_profile) {MiniTest::Mock.new.expect :new, mock_profile_object, [Hash]}

  let(:mock_reducer_instance) {MiniTest::Mock.new.expect :reduce, {reducers: []}}
  let(:mock_reducer) {MiniTest::Mock.new.expect :new, mock_reducer_instance, [Hash]}

  let(:mock_loader_instance) {MiniTest::Mock.new.expect :load_each!, {loaders: []}}
  let(:mock_loader) {MiniTest::Mock.new.expect :new, mock_loader_instance, [Hash, Hash]}


  def test_run
    config = {:reducers=>[{:reducer=>"OaiThing", :args=>"Blergh"}]}
    ingest = TinyEtl::Ingest.new(config, profile: mock_profile, reducer: mock_reducer, loader: mock_loader)
    ingest.run!
    assert_equal [{:reducer=>"OaiThing", :args=>"Blergh"}], ingest.next_components
    mock_reducer.verify
    mock_profile.verify
    mock_loader.verify
    mock_loader_instance.verify
  end

  def test_run_all
    config = {reducers: [{reducer: TestReducer, args: {foo: 'bar'}}]}
    ingest = TinyEtl::Ingest.new(config)
    ingest.run_all!
  end
end
