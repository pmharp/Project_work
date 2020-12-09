# encoding: utf-8
# copyright: 2018, The Authors

title 'CRM Windows server settings'


#insert logic to pull values from file

only_if { inspec.os.windows? }

# Day2 CPU core check

control 'TF UAT Windows CPU Day 2' do
  impact 1.0
  title 'Check total CPU cores Day 2'
  desc 'Checking the CPU count Day 2. This only checks for cores'
  script = <<-GETCPU
    $numcpu=(Get-WmiObject Win32_Processor )
    $numcpu.NumberOfCores
    GETCPU
    describe powershell(script) do
      its('strip') { should cmp == 2 }
     end
end

# Day2 RAM check

control 'TF UAT Windows RAM Day 2' do
  impact 1.0
  title 'Check total RAM Day 2'
  desc 'Checking the RAM on the server Day 2'
  script = <<-GETRAM 
    Get-WmiObject CIM_PhysicalMemory  | Measure-Object -Property capacity -Sum | % { [Math]::Round(($_.sum / 1GB), 2) } 
  GETRAM
  describe powershell(script) do 
    its('strip') { should cmp == 6 } 
  end
end

# Day2 check for creation of new drives E:\, F:\, G:\ with specific label and size as specified below

control 'TF UAT Windows E:\ Drive check' do
  impact 0.2
  title 'QA check drives'
  desc 'Check that app teams E: drive exists'
  describe file('E:') do
    it { should exist }
  end
  describe command('Get-Volume E | select FileSystemLabel') do
    its(:stdout) { should match 'e_app_1gb' }
  end
  
  describe command('get-disk 2 | select size | % {[Math]::Round(($_.Size/1GB))}') do
    its(:stdout) { should match '1' }
  end
end

control 'TF UAT Windows F:\ Drive check' do
  impact 0.2
  title 'QA check drives'
  desc 'Check that app teams F: drive exists'
  describe file('F:') do
    it { should exist }
  end
  describe command('Get-Volume F | select FileSystemLabel') do
    its(:stdout) { should match 'f_app_2gb' }
  end
  describe command('get-disk 3 | select size | % {[Math]::Round(($_.Size/1GB))}') do
    its(:stdout) { should match '2' }
  end
end

control 'TF UAT Windows G:\ Drive check' do
  impact 0.2
  title 'QA check drives'
  desc 'Check that app teams G: drive exists'
  describe file('G:') do
    it { should exist }
  end
  describe command('Get-Volume G | select FileSystemLabel') do
    its(:stdout) { should match 'g_app_3gb' }
  end
  describe command('get-disk 4 | select size | % {[Math]::Round(($_.Size/1GB))}') do
    its(:stdout) { should match '3' }
  end
end