# -*- encoding: utf-8 -*-
require File.expand_path('../lib/msewage-importer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Juan C. Müller"]
  gem.email         = ["jcmuller@gmail.com"]
  gem.description   = %q{Import data from JSON or CSV files into mSewage (mSewage.org)}
  gem.summary       = %q{Help populate the mSewage database}
  gem.homepage      = "http://github.com/jcmuller/msewage-importer"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "msewage-importer"
  gem.require_paths = ["lib"]
  gem.version       = Msewage::Importer::VERSION
  gem.license       = "MIT"

  gem.add_dependency("geocoder")
  gem.add_dependency("hashie")
  gem.add_dependency("command_line_helper")
  gem.add_dependency("uuid")

  gem.add_development_dependency("rake")
  gem.add_development_dependency("guard")
  gem.add_development_dependency("guard-bundler")
  gem.add_development_dependency("guard-ctags-bundler")
  gem.add_development_dependency("guard-rspec")
  gem.add_development_dependency("terminal-notifier-guard")
  gem.add_development_dependency("pry-debugger")
end
