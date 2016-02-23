require 'json'

module TinyEtl
  # Transform a ruby hash into an array
  class JsonTransformer
    attr_accessor :initial_state
    def initialize(args: {}, state: {})
      @initial_state = state
    end

    def state
      initial_state.merge(load_data)
    end

    private

    def load_data
      { data: initial_state.to_json }
    end
  end
end
