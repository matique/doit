$:.push File.expand_path("../lib", __FILE__)
require 'globals'

Gem::Specification.new do |gem|
  gem.name    = 'doit'
  gem.version = Globals::VERSION
  gem.summary = "Simple local & remote script executor"
  gem.description = "Run good old shell/bash scripts locally or remotely(ssh)."

  gem.authors  = ['Dittmar Krall']
  gem.email    = 'dittmar.krall@matique.de'
  gem.homepage = 'http://www.matique.de'
  gem.license  = 'MIT'

  gem.add_dependency 'micro-optparse', '~> 0'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- test`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

end
