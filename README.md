# Tiny ETL

A Tiny Ruby ETL Library. Chain together a set of reducer classes and pipe the result into one or more loader classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tiny_etl'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tiny_etl

## Usage

Create an Ingest Profile YAML file

example profile.yml:
```
:reducers:
  - :reducer: TinyEtl::OaiExtractor
    :args:
      :base_uri: 'https://server16022.contentdm.oclc.org/oai.php'
  - :reducer: TinyEtl::ContentdmExtractor
    :args:
      :base_uri: 'https://server16022.contentdm.oclc.org/dmwebservices/index.php'
  - :reducer: TinyEtl::JsonTransformer
:loaders:
  - :loader: TinyEtl::FileLoader
    :args:
      :dir: '/tmp/data'
```

Create a Ruby file and run the ingester (a single batch of OAI results in this case):

app.rb
```
require 'tiny_etl'

config = YAML.load(File.read("#{File.dirname(__FILE__)}/profile.yml"))

ingest = TinyEtl::Ingest.new(config).run!
```

$ ruby app.rb

Ingest Public Interface

| Method  | Description |
| ------------- | ------------- |
| **run!**  | Run the all reducers and loaders specified within configuration passed to ```Ingest.new```ruby  |
| **run_all!**  | Run the ingest process (all reducers and loaders) recursively until the **stop?** method evaluates to ```true```ruby   |
| **stop?**  | Checks the **state** resulting from a set of reducers to see if a **stop** semaphore has been returned (```state.fetch(:stop, false)```ruby)  |
| **next_profile**  | Merges new reducer configuration returned within the state resulting from processing a set of reducers into the original configuration. This allows batch-oriented reducers such as an OAI extractor to pass successive parameters to themselves on each ingest run.  The result of this method call can be passed directly to ```Ingest.new```ruby in order to request the next batch of results. Used in combination with **stop2**, you may construct your own recursive batch ingest process. |

## Your own Reducers and Loaders

### Reducers

Reducers represent both extractors and transformers of your ETL data, and they are just Plain Old Ruby Objects (PORO). Several reducers have been provided as example implementations in the lib/tiny_etl/reducers directory of this gem. A reducer is a class that has at least two named arguments: *args* and *state* and must respond to a *state* method. For example:


```
  class AddNewStuff
    attr_accessor :initial_state
    def initialize(args: {}, state: {})
      @initial_state = state
    end

    def state
      initial_state.merge(new_stuff)
    end

    private

    def new_stuff
      { new_stuff: 'some new stuff here' }
    end
  end
end
```

Reducers are called in the order in which they are declared in an Ingest Profile. Data from each reducer is passed to successive reducers, the final product being the result of all reducers on this data. Once each reducer has been called, the resulting state is passed to loaders to persist this data.

## Loaders

Loaders are very similar to reducers except that loaders are not allowed to modify the state. Each loader is given the final state produced by the reducers. Loaders accept *state* and *arg* keyword arguments and respond to a *load!* message.

```
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
      file_class.open(filepath, 'w') { |file| file.write(data) }
    end

    private

    def data
      @data ||= state.fetch(:data, '')
    end

    def filepath
      "#{dir}/#{filename}.json"
    end

    def filename
      Digest::SHA1.hexdigest data
    end

    def dir
      args.fetch(:dir)
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tiny_etl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License (Temporary)

© 2016 Regents of the University. Of Minnesota. All rights reserved.

(Awaiting approval for MIT license.)

