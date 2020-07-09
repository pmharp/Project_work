# -*- encoding: utf-8 -*-
# stub: win32-certstore 0.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "win32-certstore".freeze
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "yard.run" => "yri" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chef Software".freeze]
  s.date = "2020-01-14"
  s.email = ["oss@chef.io".freeze]
  s.homepage = "https://github.com/chef/win32-certstore".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Ruby library for accessing the certificate store on Windows.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_runtime_dependency(%q<mixlib-shellout>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
      s.add_dependency(%q<mixlib-shellout>.freeze, [">= 0"])
      s.add_dependency(%q<ffi>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<mixlib-shellout>.freeze, [">= 0"])
    s.add_dependency(%q<ffi>.freeze, [">= 0"])
  end
end
