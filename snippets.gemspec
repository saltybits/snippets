$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "snippets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "snippets"
  s.version     = Snippets::VERSION
  s.authors     = ["Ryan Mohr", "Salty Bits"]
  s.email       = ["ryan@saltybits.co"]
  s.homepage    = "http://github.com/saltybits/snippets"
  s.summary     = "A simple, developer focused CMS for Rails."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "paper_trail", "~> 2.7.0"

  s.add_development_dependency "sqlite3"
end
