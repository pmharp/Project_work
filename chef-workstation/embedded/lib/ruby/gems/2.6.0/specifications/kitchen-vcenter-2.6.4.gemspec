# -*- encoding: utf-8 -*-
# stub: kitchen-vcenter 2.6.4 ruby lib

Gem::Specification.new do |s|
  s.name = "kitchen-vcenter".freeze
  s.version = "2.6.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chef Software".freeze]
  s.date = "2020-02-18"
  s.description = "Test Kitchen driver for VMware vCenter using SDK".freeze
  s.email = ["oss@chef.io".freeze]
  s.homepage = "https://github.com/chef/kitchen-vcenter".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Test Kitchen driver for VMare vCenter".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
      s.add_runtime_dependency(%q<test-kitchen>.freeze, [">= 1.16", "< 3.0"])
      s.add_runtime_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
      s.add_dependency(%q<test-kitchen>.freeze, [">= 1.16", "< 3.0"])
      s.add_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
    s.add_dependency(%q<test-kitchen>.freeze, [">= 1.16", "< 3.0"])
    s.add_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
