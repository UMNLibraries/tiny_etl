# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tiny_etl/version'

Gem::Specification.new do |spec|
  spec.name          = 'tiny_etl'
  spec.version       = TinyEtl::VERSION
  spec.authors       = ['Chad Fennell']
  spec.email         = ['fenne035@umn.edu']

  spec.summary       = %q{A Tiny Ruby ETL Library}
  spec.description   = %q{Chain together a set of plain old Ruby reducers and pipe the result into one or more plain old Ruby loaders.}
  spec.license       = "© 2016 Regents of the Univ. Of Minnesota. All rights reserved"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://dont-publish-this-gem-yet.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.1'
  spec.add_development_dependency 'webmock', '~> 2.13', '>= 2.13.0'
  spec.add_development_dependency 'guard', '~> 2.13', '>= 2.13.0'
  spec.add_development_dependency 'guard-shell', '~> 0.7.1'
  spec.add_development_dependency 'oai', '~> 0.4.0'
end