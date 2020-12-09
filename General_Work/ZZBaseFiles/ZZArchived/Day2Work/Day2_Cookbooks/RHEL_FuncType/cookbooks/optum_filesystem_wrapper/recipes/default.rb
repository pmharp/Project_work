#
# Cookbook:: optum_filesystem_wrapper
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node['platform']
when 'redhat'
  include_recipe 'optum_filesystem::default'

  node['redhat']['nfs'].each do |nfs_mount|
    directory nfs_mount['local_mount_path'] do
      action :create
    end

    mount nfs_mount['local_mount_path'] do
        device "#{nfs_mount['device_name']}:#{nfs_mount['mount_path']}"
        fstype 'nfs'
        options 'rw,nolock'
        action [:mount, :enable]
    end

    directory nfs_mount['local_mount_path'] do
      owner nfs_mount['local_path_owner']
      group nfs_mount['local_path_group']
      mode nfs_mount['local_path_permission_mode']
      action :create
    end
  end
end
