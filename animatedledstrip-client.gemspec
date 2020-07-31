lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "animatedledstrip-client"
  spec.version       = "0.6.1"
  spec.authors       = ["Max Narvaez"]
  spec.email         = ["mnmax.narvaez3@gmail.com"]

  spec.summary       = "Library for connecting to an AnimatedLEDStripServer"
  spec.homepage      = "https://github.com/AnimatedLEDStrip/client-ruby"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "simplecov"
  spec.add_runtime_dependency "url"

  spec.add_development_dependency "mocha"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
