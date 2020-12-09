# encoding: utf-8
# copyright: 2018, The Authors

title 'TF UAT Apache RHEL server settings'

# load data from Terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
servername = params['TF_OUTPUT_RESOURCE_NAME-servername']['value']
cpu = params['TF_OUTPUT_RESOURCE_NAME-cpu']['value']
memory = params['TF_OUTPUT_RESOURCE_NAME-memory']['value']

# need servername test
only_if { sys_info.hostname.downcase == servername }


# Day1 check for Apache
control 'TF_OUTPUT_RESOURCE_NAME-Apache' do
  impact 1.0
  title 'Check if Apache is installed and confirm port'
  desc 'Check if Apache is installed and confirm port'
  describe port(1080) do
    it { should be_listening }
    its('protocols') { should cmp 'tcp' }
  end
  describe processes('httpd') do
    it { should exist }
  end
end

control 'TF_OUTPUT_RESOURCE_NAME-sdc and /ebiz check' do
  impact 1.0
  title 'sdc and /ebiz Configuration Check'
  desc 'sdc and /ebiz Configuration Check'
  describe file('/ebiz') do
    it { should exist }
    its('owner') { should eq 'wsuser' }
    its('group') { should eq 'webapp' }
  end
  describe command('lsblk -I 8 -d') do
    its(:stdout) { should match 'sdc' }
  end
  describe command("lsblk -I 8 -d | grep sdc | awk '{print $4'}") do
    its(:stdout) { should match '124G' }
  end
end

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