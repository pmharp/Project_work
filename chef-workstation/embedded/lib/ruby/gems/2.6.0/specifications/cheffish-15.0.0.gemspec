# -*- encoding: utf-8 -*-
# stub: cheffish 15.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cheffish".freeze
  s.version = "15.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chef Software Inc.".freeze]
  s.date = "2020-02-20"
  s.description = "A set of Chef resources for configuring Chef.".freeze
  s.email = "oss@chef.io".freeze
  s.homepage = "https://github.com/chef/cheffish".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6.0".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A set of Chef resources for configuring Chef.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chef-zero>.freeze, [">= 14.0"])
      s.add_runtime_dependency(%q<net-ssh>.freeze, [">= 0"])
    else
      s.add_dependency(%q<chef-zero>.freeze, [">= 14.0"])
      s.add_dependency(%q<net-ssh>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<chef-zero>.freeze, [">= 14.0"])
    s.add_dependency(%q<net-ssh>.freeze, [">= 0"])
  end
end
