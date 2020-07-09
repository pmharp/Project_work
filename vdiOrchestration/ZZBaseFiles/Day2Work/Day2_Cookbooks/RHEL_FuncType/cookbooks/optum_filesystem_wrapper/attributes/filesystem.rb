case node['platform']
when 'redhat'
  # Find Red Hat release version
  pv = node['platform_version'].split('.')[0]

  # Call implementation recipe based on platform version
  if pv == '6'
      fsformat = 'ext4'
  else
      fsformat = 'xfs'
  end


  # If one or more local disks need to be configured, fill in the below values after uncommenting the json.
  # Repeat the elements of the hash for as many disks needed configured.

  node.override['optum_filesystem']['server']['LV'] = [
    {
        'owner' => '2NDUNIXID',                         # Secondary UNIX ID for admin LINUX devices, ID must have access to server
        'group' => 'dce',                               # Must be valid UNIX group
        'physical_volume_name' => '/dev/sdc',           # Physical Volume name on server, i.e sdc, sdd,sde.  Run lsblk cmd on server to see volume names that were built/available
        'mode' => '755',                                # Permissions needed
        'name' => 'lv_SDC_FSNAME',                      # Edit "SDC_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
        'vg' => "vg_#{node['hostname']}_SDC_FSNAME",    # Edit "SDC_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
        'size' => '100%VG', 
        'fs_format' => "#{fsformat}", 
        'mount_point' => "/SDC_FSNAME",                 # Edit "SDC_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
        'mount_options' => 'defaults',
    }, 
    #  {
    #     'owner' => '2NDUNIXID',                         # Secondary UNIX ID for admin LINUX devices, ID must have access to server
    #     'group' => 'dce',                               # Must be valid UNIX group
    #     'physical_volume_name' => '/dev/sdd',           # Physical Volume name on server, i.e sdc, sdd,sde.  Run lsblk cmd on server to see volume names that were built/available
    #     'mode' => '755',                                # Permissions needed
    #     'name' => 'lv_SDD_FSNAME',                      # Edit "SDD_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
    #     'vg' => "vg_#{node['hostname']}_SDD_FSNAME",    # Edit "SDD_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
    #     'size' => '100%VG', 
    #     'fs_format' => "#{fsformat}", 
    #     'mount_point' => "/SDD_FSNAME",                 # Edit "SDD_FSNAME" portion to correct name for filesystem, shoudld be same name used for name, vg and mount_point
    #     'mount_options' => 'defaults',
    #  },
  ]
end