$: << File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |gem|

  gem.name = "rake-timer"
  gem.summary = "Times how long each of your Rake tasks take"
  gem.homepage = "http://github.com/pmoran/rake-timer"
  gem.authors = ["Peter Moran"]
  gem.email = "workingpeter@gmail.com"

  gem.version = RakeTimer::VERSION.dup
  gem.platform = Gem::Platform::RUBY

  gem.require_path = "lib"
  gem.files = Dir["lib/**/*", "README.markdown", "LICENSE"]
  gem.test_files = Dir["spec/**/*", "Rakefile"]

end
