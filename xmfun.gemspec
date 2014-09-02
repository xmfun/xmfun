# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmfun/version'

Gem::Specification.new do |spec|
  spec.name          = "xmfun"
  spec.version       = Xmfun::VERSION
  spec.authors       = ["ipmsteven"]
  spec.email         = ["steven.lyl147@gmail.com"]
  spec.description   = %q{Yet another xiami music downloader}
  spec.summary       = %q{Yet another xiami music downloader}
  spec.homepage      = "https://github.com/ipmsteven/xmfun"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "clap", "~> 1.0.0"
  spec.add_dependency "nori", "~> 2.4.0"
  spec.add_dependency "nokogiri", "~> 1.6.3.1"
  spec.add_dependency "parallel", "~> 1.2.2"
  spec.add_dependency "ruby-mp3info", "~> 0.8.4"
  spec.add_dependency "activesupport", "~> 4.1.5"
  spec.add_dependency "ruby-progressbar", "~> 1.5.1"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.3.2"
  spec.add_development_dependency "rspec", "~> 3.0.0"
  spec.add_development_dependency "pry", "~> 0.10.0"
  if RUBY_VERSION =~ /^2\./
    spec.add_development_dependency "pry-byebug", "~> 1.3.3"
  end
end
