require 'digest/sha1'

module TinyEtl
  # A Simple loader that writes data to disk
  class FileLoader
    attr_accessor :state, :args, :file_class
    def initialize(args: {}, state: {}, file_class: File)
      @state = state
      @args = args
      @file_class = file_class
    end

    def load!
      file_class.open("#{dir}/#{filename}.json", 'w') { |file| file.write(data) }
    end

    private

    def data
      @data ||= state.fetch(:data, '')
    end

    def filename
      Digest::SHA1.hexdigest data
    end

    def dir
      args.fetch(:dir)
    end
  end
end
