# optum_filesystem_wrapper

## Current Features
This cookbook will do the following for RHEL6 and RHEL7:<br />

* Local Disk Configuration
    * Create logical volume per physical volume (created during build)<br />
    * Create mount points<br />
    * Set size to 100% of raw physical volume<br />
    * Set permissions on the mount points<br />

* NAS Configuration
    * Create mount points<br />
    * Mounting the NFS shares on the specific mount locations<br />
    * Set permissions on the mount points<br />


## Pre-Reqs

You will need the following pre-reqs in order to run this cookbook:<br/>

* Owner must have access to the server before this can be run
    * This can be done during build
    * This can also be can be added later via Secure (https://secure.uhc.com/)
* Group must be valid Unix group.  Owner does not need to be a member, but it is recommended that they are
* If configuring the local disks
    * Identify physical volumes created during build (i.e sdc, sdd, sde)
    * Need to have raw physical volumes create via build
* If configuring NFS mounts
    * Ensure that the server has been authorized to access NFS (Can be done via Navigator https://mynavigator.optum.com/navigator/dist/index.html#/nasShareAlloc)


## Requirements
You will need the following in order to run this cookbook:<br/>
* Supporting cookbook lvm (https://github.optum.com/IAC-COE/lvm)
* Supporting cookbook optum_filesystem_wrapper (https://github.optum.com/IAC-COE/optum_filesystem_wrapper)
* Wrapper cookbook to specify overrides
    * Owner
    * Group
    * physical volume name
    * mode (permissions)
    * logical volume name
    * Mount point
    * Mount Path

## How to use
* Clone https://github.optum.com/IAC-COE/optum_filesystem_wrapper.git
* Clone https://github.optum.com/IAC-COE/optum_filesystem.git
* Clone https://github.optum.com/IAC-COE/lvm.git
* Edit the attributes/redhat.rb file for local disk configuration
  * Owner
  * group
  * physical_volume_name
  * mode
  * name
  * vg
  * mount_point
* Edit the attributes/redhat.rb file for NFS mount configuration
    * device_name   --> This information is recieved in email when NFS is created
    * mount_path    --> This information is recieved in email when NFS is created
    * local_mount_path  --> Local path where NFS has to be mounted
    * local_path_owner  --> Owner of Local path directory where NFS has to be mounted
    * local_path_group  --> Group of Local path directory where NFS has to be mounted
    * local_path_permission_mode  --> Permission Local path directory where NFS has to be mounted
* Copy all 3 cookbooks to cookbooks folder on server from laptop location
  * pscp -r * `<unixid>`@`<server>`.uhc.com:/home/`<unixid>`/cookbooks
  * asterisk used in this example above due to all 3 cookbooks in same folder with no other cookbooks 
* Local server run
  * run sudo chef-client -zo optum_filesystem_wrapper from /home/{secondaryid} directory locally on server
* Run from Latop
  * From Laptop ssh `<unixid>`@`<server>`.uhc.com sudo chef-client -zo optum_filesystem_wrapper 