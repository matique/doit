$LOAD_PATH.push File.expand_path("lib", __dir__)
require "globals"

Gem::Specification.new do |s|
  s.name = "doit"
  s.version = Globals::VERSION
  s.summary = "Simple local & remote script executor"
  s.description = "Run good old shell/bash scripts locally or remotely(ssh)."

  s.authors = ["Dittmar Krall"]
  s.email = "dittmar.krall@matiq.de"
  s.homepage = "https://github.com/matique/doit"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`
    .split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "micro-optparse", "~> 1"

  s.add_development_dependency "rake", "~> 13"
  s.add_development_dependency "minitest", "~> 5"
end
