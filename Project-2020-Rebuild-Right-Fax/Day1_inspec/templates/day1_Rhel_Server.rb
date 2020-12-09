# encoding: utf-8
# copyright: 2018, The Authors

title 'TF UAT RHEL server settings'

# load data from Terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
servername = params['TF_OUTPUT_RESOURCE_NAME-servername']['value']
cpu = params['TF_OUTPUT_RESOURCE_NAME-cpu']['value']
memory = params['TF_OUTPUT_RESOURCE_NAME-memory']['value']

# need servername test
only_if { sys_info.hostname.downcase == servername }

# Day1 check for CPU cores
control 'TF_OUTPUT_RESOURCE_NAME-CPU' do
  impact 1.0
  title 'Check total CPU cores'
  desc 'Checking the CPU count. This only checks for cores'
  describe command( " cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l " ) do
    its('stdout.strip.to_s') { should match cpu }
  end
end

# Day1 check for RAM
control 'TF_OUTPUT_RESOURCE_NAME-RAM' do
  impact 1.0
  title 'Check total RAM'
  desc 'Checking the RAM on the server'
  describe command("(awk '{ print $2 }' /proc/meminfo |head -n1)| awk '{print $1/1048576}'|  awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'" ) do 
    its('stdout.strip.to_s') { should match memory }
  end
end