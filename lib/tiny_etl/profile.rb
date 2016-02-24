module TinyEtl
  # Turns a has into a profile object that is used by reducers and loaders
  # within the ingest process
  class Profile
    attr_accessor :config
    def initialize(config)
      @config = symbolize(config)
    end

    def reducers
      constantize_config(config.fetch(:reducers, []), :reducer)
    end

    def loaders
      constantize_config(config.fetch(:loaders, []), :loader)
    end

    def find_config(reducer)
      reducers.index.reducers.inject { |a, _e| a[:reducer] == reducer }
    end

    def merge_reducers(replacements)
      merge_component(reducers, replacements, :reducer)
    end

    def components
      { reducers: reducers, loaders: loaders }
    end

    def replace_components(replacements)
      new_components = components
      new_components[:reducers] = replace_reducers(replacements)
      new_components[:loaders]  = replace_loaders(replacements)
      new_components
    end

    def to_h
      components
    end

    private

    # Sybolize algorithm via https://gist.github.com/Integralist/9503099
    # Sidekiq will transform our Ruby hash into a JSON hash, removing out
    # symbol key lookups. Symbolize converts them back to symbols
    def symbolize(obj)
      if obj.is_a? Hash
        return obj.reduce({}) do |memo, (k, v)|
          memo.tap { |m| m[k.to_sym] = symbolize(v) }
        end
      elsif obj.is_a? Array
        return obj.reduce([]) do |memo, v|
          memo << symbolize(v); memo
        end
      end
      obj
    end

    def replace_loaders(replacements)
      replace(loaders, replacements.fetch(:loaders, []), :loader)
    end

    def replace_reducers(replacements)
      replace(reducers, replacements.fetch(:reducers, []), :reducer)
    end

    def constantize_config(values, key)
      values.map { |config| config.merge(key => constantize(config[key])) }
    end

    def replace(components, replacements, const_key)
      components.map! do |original|
        replacement = find(replacements, original[const_key], const_key)
        !replacement.empty? ? replacement : original
      end
    end

    def find(replacements, component_const, key)
      replacements.find do |replacement|
        replacement[key] == component_const
      end || {}
    end

    # The config object may come from a YAML file with strings instead of class
    # constants
    def constantize(obj)
      Object.const_get obj.to_s
    end
  end
end
