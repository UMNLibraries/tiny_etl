require 'net/http'
require 'json'

module Tetl
  # Combins itemInfo, compoundInfo and image data from a contentdm API endpoint
  # into a single response.
  # Expects to recive an array of identifiers from an OAI extractor and
  # performs lookups against a contentdm api.
  # TODO: extract out the contentdm API functionality from extractor
  # functionality
  class ContentdmExtractor
    attr_reader :base_uri, :rest_client, :oai_extraction
    attr_accessor :id, :collection
    def initialize(args: {}, state: {}, rest_client: Net::HTTP)
      @base_uri        = args[:base_uri]
      @rest_client     = rest_client
      # This extractor expects the OAI extractor to be called first
      @oai_extraction  = state
    end

    def state
      # Replace the OAI extraction records in the state tree (but keeps the
      # resumption_token)
      content_dm_records
    end

    def item_api_request(verb, collection, id)
      request("#{base_uri}?q=#{verb}/#{collection}/#{id}/json")
    end

    def build_record(oai_record)
      @collection, @id = extract_identifiers(oai_record)
      record = json_decode(item_info)
      if  record_missing?(record)
        record = missing_record
      else
        record  = add_image(record)
        record  = record.merge(compound_objects)
      end
      record
    end

    private

    def extract_identifiers(oai_record)
      ids         = oai_record.fetch(:identifiers)
      collection  = ids[:collection]
      id          = ids[:identifier].to_i
      [collection, id]
    end

    def content_dm_records
      extraction = oai_extraction.dup
      extraction[:data] = build_each_record
      @extraction ||= extraction
    end

    def build_each_record
      oai_extraction.fetch(:data, []).map do |oai_record|
        build_record(oai_record)
      end
    end

    def item_info
      catch_item_errors(item_api_request('dmGetItemInfo', collection, id))
    end

    def catch_item_errors(response)
      item_info_error?(response.body) ? '{}' : response.body
    end

    def item_info_error?(response_body)
      response_body.include? 'Error looking up collection'
    end

    def compound_record
      item_api_request('dmGetCompoundObjectInfo', collection, id)
    end

    def image_uri(collection, id)
      "#{base_uri}/utils/ajaxhelper/" \
      "?CISOROOT=#{collection}"  \
      "&CISOPTR=#{id}"  \
      '&action=2'  \
      '&DMSCALE=100'  \
      '&DMWIDTH=10000'  \
      '&DMHEIGHT=10000'
    end

    def add_image(record)
      return record if commpound_objects?
      record.merge(image_uri: image_uri(collection, id))
    end

    def record_missing?(record)
      record == {} || record == missing_record
    end

    def missing_record
      { status: 'Record Missing', collection: collection, id: id }
    end

    def compound_record_info
      @compound_record_info ||= json_decode(compound_record.body)
    end

    def compound_objects
      if commpound_objects?
        { compound_objects: compound_with_images, record_type: 'compound' }
      else
        { record_type: 'single' }
      end
    end

    def compound_with_images
      pages = compound_record_info.fetch('page', [])
      pages.map do |page|
        page.merge(build_image_uri(collection, page['pageptr']))
      end
    end

    def build_image_uri(collection, id)
      { image_uri: image_uri(collection, id) }
    end

    def commpound_objects?
      compound_record_info['code'] != '-2'
    end

    def json_decode(json)
      JSON.parse json
    end

    def request(location)
      rest_client.get_response URI location
    end
  end
end
