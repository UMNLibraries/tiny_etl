require_relative '../test_helper'
require 'tiny_etl/loaders/file_loader'
require 'digest'

class FileLoaderTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:mock_file) {MiniTest::Mock.new.expect :open, nil, [String, String]}

  def test_load_file
    TinyEtl::FileLoader.new(args: {dir: 'foo'}, state: {},file_class: mock_file).load!
    mock_file.verify
    # Must provide a file directory path
    assert_raises KeyError do
      TinyEtl::FileLoader.new(args: {}, state: {},file_class: mock_file).load!
    end
  end

end