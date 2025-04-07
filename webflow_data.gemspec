$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webflow_data/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webflow_data"
  s.version     = WebflowData::VERSION
  s.authors     = ["Nick Mixdorf"]
  s.email       = ["nick@cohesive.cc"]
  s.homepage    = "https://github.com/cohesivecc/webflow-data"
  s.summary     = "Rails Wrapper around webflow data."
  s.description = "Webflow Data duplicates the webflow api but using rails and postgres"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails"
  s.add_dependency 'webflow-ruby'
  s.add_dependency "pg"
  s.add_dependency "sprockets-rails"
end
