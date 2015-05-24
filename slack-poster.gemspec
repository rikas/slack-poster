# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack-poster/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack-poster'
  spec.version       = Slack::VERSION
  spec.authors       = ['Ricardo Otero']
  spec.email         = ['oterosantos@gmail.com']
  spec.summary       = %q{Slack wrapper for Incoming WebHooks integrations.}
  spec.description   = %q{slack-poster is a gem to make your integration with Slack WebHooks easier.}
  spec.homepage      = 'https://github.com/rikas/slack-poster'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'pry', '~>0.10.1'
  spec.add_development_dependency 'fuubar'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'

  spec.add_dependency 'httparty', '~> 0.13.3'
end
