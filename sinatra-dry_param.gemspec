# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/dry_param/version'

Gem::Specification.new do |spec|
  spec.name          = 'sinatra-dry_param'
  spec.version       = Sinatra::DryParam::VERSION
  spec.authors       = ['Viet (Drake) Tran']
  spec.email         = ['phuocviet89@gmail.com']

  spec.summary       = 'Params validation for sinatra based on dry-schema.'
  spec.description   = 'Define your params schema with the strong library dry-schema.'
  spec.homepage      = 'https://github.com/tiev/sinatra-dry_param'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.4'

  spec.add_runtime_dependency 'dry-schema', '>= 0.3.0'
  spec.add_runtime_dependency 'sinatra', '>= 2.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
