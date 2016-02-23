require_relative './test_helper'
require 'tiny_etl/profile'

Reducer1 = Struct.new("Reducer1")
Reducer2 = Struct.new("Reducer2")
Reducer3 = Struct.new("Reducer3")
Loader   = Struct.new("Loader")

class ProfileTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:profile) do
    reducers = {reducers: [{reducer: Reducer1}, {reducer: Reducer2}]}
    loaders  = {loaders: [{loader: Loader}]}
    profile = TinyEtl::Profile.new(reducers.merge(loaders))
  end

  def test_constantizing
    profile = TinyEtl::Profile.new(reducers: [{reducer: "Reducer1"}, {reducer: "Reducer2"}])
    assert_equal Reducer1, profile.reducers.first[:reducer]
    assert_equal Reducer2, profile.reducers.last[:reducer]
  end

  def test_to_h
    expected = {:reducers=>[{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], :loaders=>[{:loader=>Struct::Loader}]}
    profile = TinyEtl::Profile.new(reducers: [{reducer: "Reducer1"}, {reducer: "Reducer2"}], loaders: [{loader: "Loader"}])
    assert_equal expected, profile.to_h
  end

  def test_replace_components
    new_components = {:reducers => [{reducer: Reducer2, args: [1]}, {reducer: Reducer1, args: ['I have some args now']}]}
    expected = {:reducers=>[{:reducer=>Struct::Reducer1, :args=>["I have some args now"]}, {:reducer=>Struct::Reducer2, :args=>[1]}], :loaders=>[{:loader=>Struct::Loader}]}
    assert_equal expected, profile.replace_components(new_components)
  end

  def test_merge_empty_components
    new_components = {}
    expected = {:reducers=>[{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], :loaders=>[{:loader=>Struct::Loader}]}
    assert_equal expected, profile.replace_components(new_components)
  end

  # Don't support adding new components via components (might be a useful feature down the road)
  def test_merge_new_components_fails
    new_components = [{:reducer=>Struct::Reducer3}]
    expected = {:reducers=>[{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], :loaders=>[{:loader=>Struct::Loader}]}
    assert_equal expected, profile.replace_components(reducers: new_components)
  end
end
