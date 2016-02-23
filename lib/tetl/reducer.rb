Dir["#{File.dirname(__FILE__)}/reducers/*.rb"].each { |file| require file }
module Tetl
  # Passes a shared state through a series of reducers. Each reducer is
  # responsible for modifying its own portion of the state and returning the
  # the modified portion of the state along with the rest of the state to the
  # next reducer
  class Reducer
    attr_reader :reducers
    def initialize(reducers: [])
      @reducers = reducers
    end

    def reduce
      reducers.inject([]) do |state, config|
        config[:reducer].new(args: config[:args], state: state).state
      end
    end
  end
end
