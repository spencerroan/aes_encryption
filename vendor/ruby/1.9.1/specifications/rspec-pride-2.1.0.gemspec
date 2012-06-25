# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rspec-pride"
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Rada"]
  s.date = "2012-02-25"
  s.description = "Mimics the functionality of minitest/pride for RSpec2"
  s.email = "mrada@marketcircle.com"
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["README.markdown"]
  s.homepage = "http://github.com/ferrous26/rspec-pride"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.17"
  s.summary = "Take pride in your testing"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["~> 2.6"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.6"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.6"])
  end
end
