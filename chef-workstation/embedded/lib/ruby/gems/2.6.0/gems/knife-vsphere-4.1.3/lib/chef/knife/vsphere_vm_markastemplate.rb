#
# Author:: Ezra Pagel (<ezra@cpan.org>)
# Contributor:: Jesse Campbell (<hikeit@gmail.com>)
# Contributor:: Bethany Erskine (<bethany@paperlesspost.com>)
# Contributor:: Adrian Stanila (https://github.com/sacx)
# License:: Apache License, Version 2.0
#

require "chef/knife"
require_relative "helpers/base_vsphere_command"

# Clone an existing template into a new VM, optionally applying a customization specification.
# usage:
# knife vsphere vm markastemplate MyVM --folder /templates
# Vspherevmmarkastemplate extends the Basevspherecommand
class Chef::Knife::VsphereVmMarkastemplate < Chef::Knife::BaseVsphereCommand
  banner "knife vsphere vm markastemplate VMNAME"

  deps do
    Chef::Knife::BaseVsphereCommand.load_deps
    require_relative "helpers/search_helper"
    include SearchHelper
  end

  common_options

  # The main run method for vm_markastemplate
  #
  def run
    $stdout.sync = true

    vmname = @name_args[0]
    if vmname.nil?
      show_usage
      fatal_exit("You must specify a virtual machine name")
    end

    vm = get_vm_by_name(vmname, get_config(:folder)) || fatal_exit("Could not find #{vmname}")

    puts "Marking VM #{vmname} as template"
    vm.MarkAsTemplate()
    puts "Finished marking VM #{vmname} as template"
  end
end
