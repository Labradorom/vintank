# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vintank/version'

Gem::Specification.new do |s|
  s.add_development_dependency('rake', '~> 0.8')
  s.add_development_dependency('rspec', '~> 2.5')
  s.add_development_dependency('webmock', '~> 1.6')
  s.add_runtime_dependency('hashie', '~> 1.0.0')
  s.add_runtime_dependency('faraday', '~> 0.5.4')
  s.add_runtime_dependency('faraday_middleware', '~> 0.3.2')
  s.add_runtime_dependency('multi_json', '~> 0.0.5')
  s.add_runtime_dependency('multi_xml', '~> 0.2.0')

  s.authors = ["Brian Romanko - BigBig Bomb", "Mike Gunderloy - Labrador Omnimedia"]
  s.description = %q{Ruby wrapper for the Vintank API}
  s.email = %q{brian@bigbigbomb.com mikeg1@labradorom.com}
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{}
  s.name = %q{vintank}
  s.platform = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.required_rubygems_version = Gem::Requirement.new(">= 1.5.2") if s.respond_to? :required_rubygems_version=
  s.summary = %q{Ruby wrapper for the Vintank API}
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.version = Vintank::VERSION
end

