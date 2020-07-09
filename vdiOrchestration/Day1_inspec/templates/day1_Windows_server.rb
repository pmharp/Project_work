# encoding: utf-8
# copyright: 2018, The Authors

title 'TF UAT Windows server settings'

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
  script = <<-GETCPU
    $numcpu=(Get-WmiObject Win32_Processor )
    $numcpu.NumberOfCores
    GETCPU
    describe powershell(script) do
      its('strip.to_s') { should match cpu }
     end
end

# Day1 check for RAM
control 'TF_OUTPUT_RESOURCE_NAME-RAM' do
  impact 1.0
  title 'Check total RAM'
  desc 'Checking the RAM on the server'
  script = <<-GETRAM 
    Get-WmiObject CIM_PhysicalMemory  | Measure-Object -Property capacity -Sum | % { [Math]::Round(($_.sum / 1GB), 2) } 
  GETRAM
  describe powershell(script) do 
    its('strip.to_s') { should match memory }
  end
end