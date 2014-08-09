# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yerb/version'

Gem::Specification.new do |spec|
  spec.name          = 'yerb'
  spec.version       = Yerb::VERSION
  spec.authors       = ['Dave Willkomm']
  spec.email         = ['dinosaurjr10@gmail.com']
  spec.summary       = %q{YAML with embedded Ruby}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dinosaurjr10/yerb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
