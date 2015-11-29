# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "mkrb"
  spec.version       = "0.1.0"
  spec.authors       = ["Brian Shirai"]
  spec.email         = ["brixen@gmail.com"]
  spec.summary       = %q{A tool to install or build a Ruby engine.}
  spec.description   = %q{The `mkrb` utility installs a pre-built binary of a Ruby engine for your platform, or alternatively, builds the Ruby engine from source code.}
  spec.homepage      = "https://github.com/rubinius/mkrb"
  spec.license       = "MPL-2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
