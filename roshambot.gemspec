# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'roshambot/version'

Gem::Specification.new do |gem|
  gem.name          = "roshambot"
  gem.version       = Roshambot::VERSION
  gem.authors       = ["tcollier"]
  gem.email         = ["tcollier@gmail.com"]
  gem.description   = %q{I'm gonna "rock" your world!}
  gem.summary       = %q{Cut it out}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
