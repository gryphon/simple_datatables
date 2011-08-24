$:.push File.expand_path("../lib", __FILE__)
require "simple_datatables/version"

Gem::Specification.new do |s|
  s.name        = "simple_datatables"
  s.version     = SimpleDatatables::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grigory"]
  s.email       = ["grigory@snsk.ru"]
  s.homepage    = "http://rubygems.org/gems/simple_datatables"
  s.summary     = %q{Simple datatables to rails mapping using meta_search, will_paginage and jsonify}
  s.description = %q{Simple data preparation from AR/Mongoid to the jQuery DataTables plugin}

  s.rubyforge_project = "data_table"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">=3.0.0"
  s.add_dependency "will_paginate", "~>3.0.pre2"
  s.add_dependency "meta_search"
  s.add_dependency "jsonify-rails"

end
