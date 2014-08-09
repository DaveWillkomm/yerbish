# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yerbish/version'

Gem::Specification.new do |spec|
  spec.name          = 'yerbish'
  spec.version       = Yerbish::VERSION
  spec.authors       = ['Dave Willkomm']
  spec.email         = ['dinosaurjr10@gmail.com']
  spec.summary       = 'YAML with embedded Ruby'
  spec.description   = 'Yerbish enables embedding Ruby in YAML files, as well as composing a YAML file from other partial YAML files.'
  spec.homepage      = 'https://github.com/dinosaurjr10/yerbish'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
