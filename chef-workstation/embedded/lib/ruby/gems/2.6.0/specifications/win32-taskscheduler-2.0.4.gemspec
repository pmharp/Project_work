# -*- encoding: utf-8 -*-
# stub: win32-taskscheduler 2.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "win32-taskscheduler".freeze
  s.version = "2.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Park Heesob".freeze, "Daniel J. Berger".freeze]
  s.date = "2019-01-04"
  s.description = "    The win32-taskscheduler library provides an interface to the MS Windows\n    Task Scheduler. With this interface you can create new scheduled tasks,\n    configure existing tasks, or delete tasks.\n".freeze
  s.email = "djberg96@gmail.com".freeze
  s.homepage = "https://github.com/chef/win32-taskscheduler".freeze
  s.licenses = ["Artistic-2.0".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A library for the Windows task scheduler".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<structured_warnings>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_development_dependency(%q<win32-security>.freeze, [">= 0"])
    else
      s.add_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_dependency(%q<structured_warnings>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
      s.add_dependency(%q<win32-security>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>.freeze, [">= 0"])
    s.add_dependency(%q<structured_warnings>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    s.add_dependency(%q<win32-security>.freeze, [">= 0"])
  end
end
