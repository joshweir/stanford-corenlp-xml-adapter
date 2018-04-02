# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "stanford_corenlp_xml_adapter/version"

Gem::Specification.new do |spec|
  spec.name          = "stanford_corenlp_xml_adapter"
  spec.version       = StanfordCorenlpXmlAdapter::VERSION
  spec.authors       = ["joshweir"]
  #spec.email         = [""]

  spec.summary       = %q{Ruby adapter to the output returned by Stanford CoreNLP XML Server.}
  spec.homepage      = "https://github.com/joshweir/stanford-corenlp-xml-adapter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15" #"~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-rails", "~> 3.5"
  spec.add_development_dependency "gem-release"
  spec.add_development_dependency "rb-fsevent"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_dependency "activesupport"
  spec.add_dependency "nokogiri"
end
