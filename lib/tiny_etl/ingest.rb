require 'yaml'
require_relative 'reducer'
require_relative 'loader'
require_relative 'profile'

module TinyEtl
  # Runs the ingest process. If run_all! is called, ingest will recurse through
  # each batch of records until a stop signal is retrieved from the state of
  # the last reducer. This means each reducer should take care to pass the
  # entire state back and only modify parts of the state that it needs to
  # modify
  class Ingest
    attr_reader :profile, :reducer, :loader, :state
    def initialize(config, reducer: Reducer, loader: Loader, profile: Profile)
      @profile  = profile.new(config)
      @reducer  = reducer
      @loader   = loader
    end

    def run!
      @state = reducer.new(reducers: profile.reducers).reduce
      loader.new(state, loaders: profile.loaders).load_each!
    end

    def run_all!
      run!
      self.class.new(next_profile.to_h).run_all! unless stop?
    end

    def next_reducers
      { reducers: profile.merge_reducers(state[:reducers]) }
    end

    private

    def next_profile
      profile.class.new(next_reducers)
    end

    def stop?
      state.fetch(:stop, false)
    end

    def extraction
      state[:extraction]
    end
  end
end
