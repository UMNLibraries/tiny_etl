require_relative '../test_helper'
require 'tetl/reducers/oai_extractor'

class OaiExtractorTest < Minitest::Test
  extend Minitest::Spec::DSL
  let(:response) do
    VCR.use_cassette("oai_first_page") do
      Tetl::OaiExtractor.new(args: {base_uri: 'https://server16022.contentdm.oclc.org/oai.php'})
    end
  end

  def test_extract_identifiers
    expected = {identifier: 2, collection: 'civilwar'}
    assert_equal expected, response.extract_identifiers('oai:testendpoint.contentdm.oclc.org:civilwar/2')
  end

  def test_state
    assert_equal 200, response.state[:data].length
    assert_equal 'swede:96:oclc-cdm-allsets:0000-00-00:9999-99-99:oai_dc', response.state[:reducers].first[:args][:resumption_token]
  end

  def test_resumption_token
    VCR.use_cassette("oai_second_page") do
      response = Tetl::OaiExtractor.new(args: {base_uri: 'https://server16022.contentdm.oclc.org/oai.php', resumption_token: 'swede:96:oclc-cdm-allsets:0000-00-00:9999-99-99:oai_dc'})
      assert_equal 'swede:296:oclc-cdm-allsets:0000-00-00:9999-99-99:oai_dc', response.state[:reducers].first[:args][:resumption_token]
    end
  end

  def test_last_batch_stop_true
    record = Class.new {
       define_method(:map) { nil }
       define_method(:resumption_token) { nil }
    }.new
    expected = {:data=>nil, :reducers=>[{:reducer=> Tetl::OaiExtractor, :args=>{:base_uri=>"https://example.com", :resumption_token=>{}}}], :stop=>true}
    mock_oai_client_object = MiniTest::Mock.new
    mock_oai_client_object.expect :list_records, record
    mock_oai_client = MiniTest::Mock.new.expect :new, mock_oai_client_object, [String]
    response = Tetl::OaiExtractor.new(args: {base_uri: 'https://example.com'}, oai_client: mock_oai_client)
    mock_oai_client_object.verify
    mock_oai_client.verify
    assert_equal expected, response.state
  end
end
