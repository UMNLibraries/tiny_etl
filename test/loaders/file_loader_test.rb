require_relative '../test_helper'
require 'letl/loaders/file_loader'
require 'digest'

class FileLoaderTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:mock_file) {MiniTest::Mock.new.expect :open, nil, [String]}

  def test_load_file
    Letl::FileLoader.new(args: {dir: 'foo'}, state: {},file_class: mock_file).load!
    mock_file.verify
    # Must provide a file directory path
    assert_raises KeyError do
      Letl::FileLoader.new(args: {}, state: {},file_class: mock_file).load!
    end
  end

end