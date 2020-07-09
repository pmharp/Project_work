# -*- encoding: utf-8 -*-
# stub: chef-api 0.10.5 ruby lib

Gem::Specification.new do |s|
  s.name = "chef-api".freeze
  s.version = "0.10.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Seth Vargo".freeze, "Tim Smith".freeze]
  s.date = "2020-01-29"
  s.description = "A tiny Chef Infra API client with minimal dependencies".freeze
  s.email = ["sethvargo@gmail.com".freeze, "tsmith84@gmail.com".freeze]
  s.homepage = "https://github.com/chef/chef-api".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Chef Infra API client in Ruby".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mixlib-log>.freeze, [">= 1", "< 4"])
      s.add_runtime_dependency(%q<mime-types>.freeze, [">= 0"])
    else
      s.add_dependency(%q<mixlib-log>.freeze, [">= 1", "< 4"])
      s.add_dependency(%q<mime-types>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<mixlib-log>.freeze, [">= 1", "< 4"])
    s.add_dependency(%q<mime-types>.freeze, [">= 0"])
  end
end
