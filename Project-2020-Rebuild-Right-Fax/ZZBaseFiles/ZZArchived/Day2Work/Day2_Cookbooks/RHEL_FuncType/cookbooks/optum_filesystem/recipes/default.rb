#
# Cookbook:: optum_filesystem
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# override variables:
# owner
# group
# physical volume name
# logical volume name
# volume group
# size
# mount_point
# filesystem format
# mode

# This cookbook should be able to handle creating multiple filesystems with differing variables including physical volume name

include_recipe 'lvm::default'

node.default['optum_filesystem']['server']['LV'] = []

node['optum_filesystem']['server']['LV'].each do |lv|
  lvm_physical_volume lv['physical_volume_name'] do
    action :create
  end
  lvm_volume_group lv['vg'] do
    physical_volumes [(lv['physical_volume_name'])]
    physical_extent_size '32M'
    action :create
    not_if "vgs | grep #{lv['vg']}"
  end
  lvm_volume_group lv['vg'] do
    physical_volumes [(lv['physical_volume_name'])]
    physical_extent_size '32M'
    action :extend
    only_if "vgs | grep #{lv['vg']}"
  end
  directory lv['mount_point'] do
    owner lv['owner']
    group lv['group']
    mode lv['mode']
    action :create
  end
  lvm_logical_volume lv['name'] do
    group lv['vg']
    size lv['size']
    filesystem lv['fs_format']
    # mount_point location: lv['mount_point'], options: lv['mount_options']
    lv_params '-y -Wy -Zy'
    action :create
    not_if "lvs | grep #{node['name']}"
  end
  lvm_logical_volume lv['name'] do
    group lv['vg']
    size lv['size']
    filesystem lv['fs_format']
    # mount_point location: lv['mount_point'], options: lv['mount_options']
    #lv_params '-y -Wy -Zy'
    action :resize
    only_if " lvs | grep #{node['name']} | awk '{print $4}' | sed -e \"s/g//\" < sudo vgs | grep #{lv['vg']} | awk '{print $6}' | sed -e \"s/^<//\" -e \"s/g//\" "
  end
  mount lv['mount_point'] do
    device "/dev/mapper/#{lv['vg']}-#{lv['name']}"
    fstype lv['fs_format']
    mount_point lv['mount_point']
    options lv['mount_options']
    action [:mount, :enable]
  end
  #  needed to have twice to actaully set the owner and group correctly
  # or will need to run the chef command 2x, 1st time sets to root:root
  directory lv['mount_point'] do
    owner lv['owner']
    group lv['group']
    mode lv['mode']
    action :create
  end
end
