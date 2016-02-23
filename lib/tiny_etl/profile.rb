module TinyEtl
  # Turns a has into a profile object that is used by reducers and loaders
  # within the ingest process
  class Profile
    attr_accessor :config
    def initialize(config)
      @config = config
    end

    def reducers
      constantize_config(config.fetch(:reducers, {}), :reducer)
    end

    def loaders
      constantize_config(config.fetch(:loaders, {}), :loader)
    end

    def find_config(reducer)
      reducers.index.reducers.inject { |a, _e| a[:reducer] == reducer }
    end

    def merge_reducers(replacements)
      reducers.map do |config|
        replacement_config = replacement_config(config[:reducer], replacements)
        !replacement_config.empty? ? replacement_config : config
      end
    end

    def to_h
      { reducers: reducers, loaders: loaders }
    end

    private

    def constantize_config(values, key)
      values.map { |config| config.merge(key => constantize(config[key])) }
    end

    def replacement_config(old_reducer, replacement_reducers)
      replacement_reducers.find do |replacement|
        replacement[:reducer] == old_reducer
      end || {}
    end

    # The config object may come from a YAML file with strings instead of class
    # constants
    def constantize(obj)
      Object.const_get obj.to_s
    end
  end
end
