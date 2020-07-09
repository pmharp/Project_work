# -*- encoding: utf-8 -*-
# stub: vsphere-automation-sdk 0.4.6 ruby lib

Gem::Specification.new do |s|
  s.name = "vsphere-automation-sdk".freeze
  s.version = "0.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["J.R. Garcia".freeze]
  s.date = "2019-10-29"
  s.description = "A Ruby SDK for the vSphere APIs".freeze
  s.email = ["jrg@vmware.com".freeze]
  s.homepage = "https://github.com/vmware/vsphere-automation-sdk-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Ruby SDK for the vSphere APIs".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vsphere-automation-appliance>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-content>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-vapi>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-vcenter>.freeze, ["~> 0.4.6"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
    else
      s.add_dependency(%q<vsphere-automation-appliance>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-content>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-vapi>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-vcenter>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    end
  else
    s.add_dependency(%q<vsphere-automation-appliance>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-content>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-vapi>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-vcenter>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
  end
end
