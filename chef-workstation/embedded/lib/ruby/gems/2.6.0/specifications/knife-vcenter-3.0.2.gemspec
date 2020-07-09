# -*- encoding: utf-8 -*-
# stub: knife-vcenter 3.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "knife-vcenter".freeze
  s.version = "3.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chef Partner Engineering".freeze]
  s.date = "2020-02-12"
  s.description = "Knife plugin to VMware vCenter.".freeze
  s.email = ["partnereng@chef.io".freeze]
  s.homepage = "https://github.com/chef/knife-vcenter".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Knife plugin to VMware vCenter.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<knife-cloud>.freeze, [">= 1.2", "< 3.0"])
      s.add_runtime_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
      s.add_runtime_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
      s.add_runtime_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
    else
      s.add_dependency(%q<knife-cloud>.freeze, [">= 1.2", "< 3.0"])
      s.add_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
      s.add_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
      s.add_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
    end
  else
    s.add_dependency(%q<knife-cloud>.freeze, [">= 1.2", "< 3.0"])
    s.add_dependency(%q<rb-readline>.freeze, ["~> 0.5"])
    s.add_dependency(%q<rbvmomi>.freeze, [">= 1.11", "< 3.0"])
    s.add_dependency(%q<vsphere-automation-sdk>.freeze, ["~> 0.4"])
  end
end
