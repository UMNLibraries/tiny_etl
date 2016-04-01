Dir["#{File.dirname(__FILE__)}/loaders/*.rb"].each { |file| require file }
module TinyEtl
  # Call each loader with state provided by reducers
  class Loader
    attr_reader :loaders, :state

    def initialize(state, loaders: [])
      @state = state
      @loaders = loaders
    end

    def load_each!
      loaders.map do |config|
        load!(config)
      end
    end

    private

    def load!(config)
      config[:loader].new(args: config[:args], state: state).load!
    rescue Exception => e
      raise "An error occurred for loader \"#{config[:loader]}\" " \
      "with arguments \"#{config[:args]}\": #{e}"
    end
  end
end
