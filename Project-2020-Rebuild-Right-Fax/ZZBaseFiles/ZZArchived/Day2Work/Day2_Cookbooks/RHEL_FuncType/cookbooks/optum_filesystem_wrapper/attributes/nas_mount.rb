case node['platform']
when 'redhat'
    # # Find Red Hat release version
    # pv = node['platform_version'].split('.')[0]

    # # Call implementation recipe based on platform version
    # if pv == '6'
    #     fsformat = 'ext4'
    # else
    #     fsformat = 'xfs'
    # end

    # If one or more NFS shares need to be configured, fill in the below values after uncommenting the json.
    # Repeat the elements of the hash for as many shares needed configured.  Assumes NAS mount has been created via Terraform or Tech.optum.com

    default['redhat']['nfs'] = [
        {
            'device_name' => 'NAS_DEVICE_NAME',       # NAS Device Name name provided in NAS email
            'mount_path' => 'NAS_EXPORT_PATH',        # NAS Export Path value provided in NAS email
            'local_mount_path' => '/LOCAL_PATH',      # Path you want on the server, must start with /
            'local_path_owner' => '2NDUNIXID',        # Secondary UNIX ID for admin LINUX devices, ID must have access to server
            'local_path_group' => 'dce',              # Must be valid UNIX group
            'local_path_permission_mode' => '0755',   # Permissions needed
        },
        # {
        #     'device_name' => 'NAS_DEVICE_NAME',       # NAS Device Name name provided in NAS email
        #     'mount_path' => 'NAS_EXPORT_PATH',        # NAS Export Path value provided in NAS email
        #     'local_mount_path' => '/LOCAL_PATH',      # Path you want on the server, must start with /
        #     'local_path_owner' => '2NDUNIXID',        # Secondary UNIX ID for admin LINUX devices, ID must have access to server
        #     'local_path_group' => 'dce',              # Must be valid UNIX group
        #     'local_path_permission_mode' => '0755',   # Permissions needed
        # },
    ]
end