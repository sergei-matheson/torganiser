# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torganiser/version'

Gem::Specification.new do |spec|
  spec.name          = 'torganiser'
  spec.version       = Torganiser::VERSION
  spec.authors       = ['']
  spec.email         = ['']
  spec.summary       = 'Organises episode files according to filename.'
  spec.description   = 'Organises episode files according to filename.'
  spec.homepage      = 'https://github.com/sergei-matheson/torganiser'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'clamp'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'cane'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
