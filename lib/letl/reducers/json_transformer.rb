require 'json'

module Letl
  # Transform a ruby hash into an array
  class JsonTransformer
    attr_accessor :initial_state
    def initialize(args: {}, state: {})
      @initial_state = state
    end

    def state
      initial_state.merge(data)
    end

    private

    def data
      { data: initial_state.fetch(:data).to_json }
    end
  end
end
