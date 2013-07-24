# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'common_validators/version'

Gem::Specification.new do |spec|
  spec.name          = "common_validators"
  spec.version       = CommonValidators::VERSION
  spec.authors       = ["Gerry Shaw"]
  spec.email         = ["gshaw@reinvent.com"]
  spec.summary       = %q{Common validators for Rails applications}
  spec.homepage      = "https://github.com/gshaw/common_validators"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9"

  spec.add_dependency "rails", "~> 3.2"
  spec.add_dependency "bigdecimal"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "guard-test"
end
