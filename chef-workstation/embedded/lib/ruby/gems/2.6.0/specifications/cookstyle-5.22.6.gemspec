# -*- encoding: utf-8 -*-
# stub: cookstyle 5.22.6 ruby lib

Gem::Specification.new do |s|
  s.name = "cookstyle".freeze
  s.version = "5.22.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/chef/cookstyle/issues", "changelog_uri" => "https://github.com/chef/cookstyle/blob/master/CHANGELOG.md", "documentation_uri" => "https://docs.chef.io/cookstyle.html", "homepage_uri" => "https://github.com/chef/cookstyle", "source_code_uri" => "https://github.com/chef/cookstyle" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Thom May".freeze, "Tim Smith".freeze]
  s.date = "2020-02-28"
  s.email = ["thom@chef.io".freeze, "tsmith@chef.io".freeze]
  s.executables = ["cookstyle".freeze]
  s.files = ["bin/cookstyle".freeze]
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Cookstyle is a code linting tool that helps you to write better Chef Infra cookbooks by detecting and automatically correcting style, syntax, and logic mistakes in your code.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rubocop>.freeze, ["= 0.75.1"])
    else
      s.add_dependency(%q<rubocop>.freeze, ["= 0.75.1"])
    end
  else
    s.add_dependency(%q<rubocop>.freeze, ["= 0.75.1"])
  end
end
