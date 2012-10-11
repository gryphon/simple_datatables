$:.push File.expand_path("../lib", __FILE__)
require "rails_datatables/version"

Gem::Specification.new do |s|
  s.name        = "rails_datatables"
  s.version     = RailsDatatables::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Grigory", "Zack"]
  s.email       = ["sakchai@artellectual.com"]
  s.homepage    = "http://github.com/artellectual/rails-datatables"
  s.summary     = %q{Rails datatables to rails mapping using meta_search, will_paginage / Kaminari and jsonify}
  s.description = %q{Rails datatables to rails mapping using meta_search, will_paginage / Kaminari and jsonify}

  s.rubyforge_project = "data_table"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", [">= 3.1.0","< 4.0.0"]
  s.add_dependency "meta_search", '~> 1.1.0'
  s.add_dependency "jsonify-rails"
end
