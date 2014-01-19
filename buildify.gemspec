# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildify/version'

Gem::Specification.new do |spec|
  spec.name          = "buildify"
  spec.version       = Buildify::VERSION
  spec.authors       = ["j4m355"]
  spec.email         = ["e@mailjames.com"]
  spec.description   = "have a bit of version"
  spec.summary       = "Get some version"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "time_diff"
end
