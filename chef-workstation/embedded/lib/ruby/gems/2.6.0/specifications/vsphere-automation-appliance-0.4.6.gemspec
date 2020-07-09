# -*- encoding: utf-8 -*-
# stub: vsphere-automation-appliance 0.4.6 ruby lib

Gem::Specification.new do |s|
  s.name = "vsphere-automation-appliance".freeze
  s.version = "0.4.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["J.R. Garcia".freeze]
  s.date = "2019-10-29"
  s.description = "A Ruby SDK for the vSphere APIs (Appliance)".freeze
  s.email = ["jrg@vmware.com".freeze]
  s.homepage = "https://github.com/vmware/vsphere-automation-sdk-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Ruby SDK for the vSphere APIs (Appliance)".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
      s.add_runtime_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.12.2"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 3.6"])
    else
      s.add_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
      s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.12.2"])
      s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
      s.add_dependency(%q<vcr>.freeze, ["~> 5.0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 3.6"])
    end
  else
    s.add_dependency(%q<vsphere-automation-runtime>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<vsphere-automation-cis>.freeze, ["~> 0.4.6"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.0"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.12.2"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.7"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.73.0"])
    s.add_dependency(%q<vcr>.freeze, ["~> 5.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 3.6"])
  end
end
