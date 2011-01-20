# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "howdy/version"

Gem::Specification.new do |s|
  s.name        = "howdy"
  s.version     = Howdy::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michał Łomnicki"]
  s.email       = ["michal.lomnicki@gmail.com"]
  s.homepage    = "https://github.com/mlomnicki/howdy"
  s.summary = %q{Query web dictionaries from command line}
  s.description = %q{Howdy is a tool that allows querying web dictionaries from a command line. It fetches HTML, parses it and prints results to standard output.}

  s.rubyforge_project = "howdy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("nokogiri")
end

