require_relative './test_helper'
require 'letl/profile'

Reducer1 = Struct.new("Reducer1")
Reducer2 = Struct.new("Reducer2")
Reducer3 = Struct.new("Reducer3")
Loader   = Struct.new("Loader")

class ProfileTest < Minitest::Test
  extend Minitest::Spec::DSL

  def test_constantizingg
    profile = Letl::Profile.new(reducers: [{reducer: "Reducer1"}, {reducer: "Reducer2"}])
    assert_equal Reducer1, profile.reducers.first[:reducer]
    assert_equal Reducer2, profile.reducers.last[:reducer]
  end

  def test_to_h
    expected = {:reducers=>[{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], :loaders=>[{:loader=>Struct::Loader}]}
    profile = Letl::Profile.new(reducers: [{reducer: "Reducer1"}, {reducer: "Reducer2"}], loaders: [{loader: "Loader"}])
    assert_equal expected, profile.to_h
  end

  def test_merge_reducers
    profile = Letl::Profile.new({reducers: [{reducer: Reducer1}, {reducer: Reducer2}]})
    new_reducers = [{reducer: Reducer2, args: [1]}]
    assert_equal [{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2, :args=>[1]}], profile.merge_reducers(new_reducers)
    new_reducers = []
    assert_equal [{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], profile.merge_reducers(new_reducers)
    new_reducers = [{:reducer=>Struct::Reducer3}]
    assert_equal [{:reducer=>Struct::Reducer1}, {:reducer=>Struct::Reducer2}], profile.merge_reducers(new_reducers)
  end
end
