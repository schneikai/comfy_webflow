$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "comfy_webflow/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "comfy_webflow"
  s.version     = ComfyWebflow::VERSION
  s.authors     = ["Kai Schneider"]
  s.email       = ["schneikai@gmail.com"]
  s.homepage    = "https://github.com/schneikai/comfy_webflow"
  s.summary     = "Makes it easy to serve Webflow sites with ComfortableMexicanSofa."
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "comfortable_mexican_sofa", "~> 1.12"
  s.add_dependency "nokogiri", "~> 1.6"

  s.add_development_dependency "sqlite3"
end
