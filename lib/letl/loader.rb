Dir["#{File.dirname(__FILE__)}/loaders/*.rb"].each { |file| require file }
module Letl
  # Call each loader with state provided by reducers
  class Loader
    attr_reader :loaders, :state

    def initialize(state, loaders: [])
      @state = state
      @loaders = loaders
    end

    def load_each!
      loaders.map do |config|
        config[:loader].new(args: config[:args], state: state).load!
      end
    end
  end
end
