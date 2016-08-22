# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'checks/version'

Gem::Specification.new do |spec|
  spec.name          = "checks"
  spec.version       = Checks::VERSION
  spec.authors       = ["Darcy Laycock"]
  spec.email         = ["darcy@gyde.tv"]
  spec.summary       = %q{Trigger-based Health Check support tools.}
  spec.description   = %q{Helps provide trigger-based healthcheck support (e.g. for Cron tasks)}
  spec.homepage      = "https://github.com/gyde-tv/checks"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
