# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imp/version"

Gem::Specification.new do |s|
  s.name        = "imp"
  s.version     = Imp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Christian Pedaschus"]
  s.email       = ["pc@matt-schwarz.com"]
  s.homepage    = "http://www.matt-schwarz.com"
  s.summary     = %q{Template for integrated Rails 3.1 Engines}
  s.description = %q{Includes a Rails dummy application to run the engine specs standalone and under a real app}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]


  ## taken from rspec, so probably we dont need the gemfile at all?
  s.add_runtime_dependency(%q<activesupport>, ["~> 3.1"])
#  s.add_runtime_dependency(%q<actionpack>, ["~> 3.1"])
#  s.add_runtime_dependency(%q<railties>, ["~> 3.1"])
  s.add_runtime_dependency "arel", "~> 2.0"
  s.add_runtime_dependency "rack", "~> 1.2"
  s.add_runtime_dependency "rspec", "~> 2.4"
  s.add_runtime_dependency "rspec-core", "~> 2.4"
  s.add_runtime_dependency "rspec-expectations", "~> 2.4"
  s.add_runtime_dependency "rspec-mocks", "~> 2.4"
  s.add_runtime_dependency "rspec-rails", "~> 2.4"
  s.add_runtime_dependency "database_cleaner" , "~> 0.6"
  s.add_runtime_dependency "factory_girl_rails" #, "~> 2.4"
  s.add_runtime_dependency "capybara", "~> 0.4"


  s.add_development_dependency "hirb"
  s.add_development_dependency "awesome_print"

end
