
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'slack/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack-poster'
  spec.version       = Slack::VERSION.dup
  spec.authors       = ['Ricardo Otero']
  spec.email         = ['oterosantos@gmail.com']
  spec.summary       = 'Slack wrapper for Incoming WebHooks integrations.'
  spec.description   = 'Slack Poster is a gem to make your integration with Slack WebHooks easier.'
  spec.homepage      = 'https://github.com/rikas/slack-poster'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '> 1.10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.37', '> 0.35'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.22'

  spec.add_runtime_dependency 'faraday', '~> 0.9'
end
