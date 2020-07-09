# -*- encoding: utf-8 -*-
# stub: rdp-ruby-wmi 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rdp-ruby-wmi".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Gordon Thiesfeld".freeze]
  s.date = "2009-12-15"
  s.description = "ruby-wmi\n    by Gordon Thiesfeld\n    http://ruby-wmi.rubyforge.org/\n    gthiesfeld@gmail.com\n\n== DESCRIPTION:\n\n  ruby-wmi is an ActiveRecord style interface for Microsoft's Windows\n  Management Instrumentation provider.\n\n  Many of the methods in WMI::Base are borrowed directly, or with some\n  modification from ActiveRecord.\n    http://api.rubyonrails.org/classes/ActiveRecord/Base.html\n\n  The major tool in this library is the #find method.  For more\n  information, see WMI::Base.\n\n  There is also a WMI.sublasses method included for reflection.\n\n== SYNOPSIS:\n\n  # The following code sample kills all processes of a given name\n  # (in this case, Notepad), except the oldest.\n\n    require 'ruby-wmi'\n\n    procs = WMI::Win32_Process.find(:all,\n                                    :conditions => { :name => 'Notepad.exe' }\n                                   )\n    morituri = procs.sort_by{|p| p.CreationDate } #those who are about to die\n    morituri.shift\n    morituri.each{|p| p.terminate }\n\n== REQUIREMENTS:\n\n    Windows 2000 or newer\n    Ruby 1.8\n\n== INSTALL:\n\n  gem install ruby-wmi\n\n== LICENSE:\n\n(The MIT License)\n\nCopyright (c) 2007 Gordon Thiesfeld\n\nPermission is hereby granted, free of charge, to any person obtaining\na copy of this software and associated documentation files (the\n'Software'), to deal in the Software without restriction, including\nwithout limitation the rights to use, copy, modify, merge, publish,\ndistribute, sublicense, and/or sell copies of the Software, and to\npermit persons to whom the Software is furnished to do so, subject to\nthe following conditions:\n\nThe above copyright notice and this permission notice shall be\nincluded in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,\nEXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\nMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\nIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\nCLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\nTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\nSOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n".freeze
  s.email = "gthiesfeld@gmail.com".freeze
  s.extra_rdoc_files = ["README.txt".freeze]
  s.files = ["README.txt".freeze]
  s.homepage = "http://rubyforge.org/projects/ruby-wmi/".freeze
  s.rdoc_options = ["--title".freeze, "rdp-ruby-wmi".freeze, "--main".freeze, "README.txt".freeze, "--line-numbers".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "ruby-wmi is an ActiveRecord style interface for Microsoft's Windows Management Instrumentation provider.".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version
end
