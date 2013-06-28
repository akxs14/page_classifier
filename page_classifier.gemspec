# encoding: utf-8

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "page_classifier"
  spec.version       = "0.0.1"
  spec.authors       = ["madvertise Mobile Advertising GmbH"]
  spec.email         = ["tech@madvertise.com"]
  spec.description   = "madvertise Page Classifier"
  spec.summary       = "madvertise Page Classifier"
  spec.homepage      = "http://madvertise.com"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["", "lib", "lib/io_manager", "lib/crawler"]
end
