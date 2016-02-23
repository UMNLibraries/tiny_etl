require 'oai'

module TinyEtl
  # A basic example of an OAI extractor. This version works in tandem with
  # the contentdm extractor
  class OaiExtractor
    attr_reader :response
    attr_accessor :args
    def initialize(args: {}, state: {}, oai_client: OAI::Client)
      @args = args
      @response = fetch_records(client(oai_client), args_resumption_token)
    end

    def state
      { data: records, reducers: [next_reducer_args], stop: stop? }
    end

    def extract_identifiers(identifier)
      collection, id = identifier.split(':').last.split('/')
      { collection: collection, identifier: id.to_i }
    end

    private

    def stop?
      response_resumption_token.empty?
    end

    def client(oai_client)
      oai_client.new(base_uri)
    end

    def args_resumption_token
      args.fetch(:resumption_token, {})
    end

    def base_uri
      args[:base_uri]
    end

    def next_reducer_args
      { reducer: self.class, args: next_args }
    end

    def next_args
      args.merge(resumption_token: response_resumption_token)
    end

    def response_resumption_token
      response.resumption_token || {}
    end

    def fetch_records(client, resumption_token = {})
      if !resumption_token.empty?
        client.list_records(resumption_token: resumption_token)
      else
        client.list_records
      end
    end

    def records
      response.map do |record|
        {
          status: record.header.status,
          identifiers: extract_identifiers(record.header.identifier)
        }
      end
    end
  end
end
