require 'yaml'
require_relative 'reducer'
require_relative 'loader'
require_relative 'profile'

module TinyEtl
  # Runs the ingest process. Each reducer should take care to pass the
  # entire state back and only modify parts of the state that it needs to
  # modify.
  class Ingest
    attr_reader :profile, :reducer, :loader, :state
    def initialize(config, reducer: Reducer, loader: Loader, profile: Profile)
      @profile  = profile.new(config)
      @reducer  = reducer
      @loader   = loader
    end

    def run!
      @state = reducer.new(reducers: profile.reducers).reduce
      loader.new(state, loaders: loaders).load_each!
      self
    end

    def stop?
      state.fetch(:stop, false)
    end

    def next_profile
      profile.class.new(next_components)
    end

    private

    def next_reducers
      state.fetch(:reducers, [])
    end

    def next_components
      profile.replace_components(reducers: next_reducers, loaders: loaders)
    end

    # For now, loaders can't modify loader config they way that reducers can.
    # This is because reducers like OAI return config that allows them to fetch
    # successive batches of content
    def loaders
      @loaders ||= profile.loaders
    end

    def extraction
      state[:extraction]
    end
  end
end
