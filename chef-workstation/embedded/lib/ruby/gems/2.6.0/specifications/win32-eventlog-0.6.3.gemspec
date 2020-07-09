# -*- encoding: utf-8 -*-
# stub: win32-eventlog 0.6.3 ruby lib

Gem::Specification.new do |s|
  s.name = "win32-eventlog".freeze
  s.version = "0.6.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Daniel J. Berger".freeze, "Park Heesob".freeze]
  s.date = "2015-05-20"
  s.description = "    The win32-eventlog library provides an interface to the MS Windows event\n    log. Event logging provides a standard, centralized way for applications\n    (and the operating system) to record important software and hardware\n    events. The event-logging service stores events from various sources in a\n    single collection called an event log. This library allows you to inspect\n    existing logs as well as create new ones.\n".freeze
  s.email = "djberg96@gmail.com".freeze
  s.extra_rdoc_files = ["README".freeze, "CHANGES".freeze, "MANIFEST".freeze, "doc/tutorial.txt".freeze]
  s.files = ["CHANGES".freeze, "MANIFEST".freeze, "README".freeze, "doc/tutorial.txt".freeze]
  s.homepage = "http://github.com/djberg96/win32-eventlog".freeze
  s.licenses = ["Artistic 2.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Interface for the MS Windows Event Log.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<ptools>.freeze, [">= 0"])
    else
      s.add_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<ptools>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<ptools>.freeze, [">= 0"])
  end
end
