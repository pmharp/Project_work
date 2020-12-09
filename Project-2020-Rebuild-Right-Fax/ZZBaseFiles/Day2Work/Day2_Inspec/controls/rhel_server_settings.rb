# encoding: utf-8
# copyright: 2018, The Authors

title 'CRM RHEL server settings'


#insert logic to pull values from file

only_if { inspec.os.redhat? }

# Day2 check for CPU cores
control 'TF UAT rhel CPU Day 2' do
  impact 1.0
  title 'Check total CPU cores Day 2'
  desc 'Checking the CPU count. This only checks for cores Day 2'
  describe command( " cat /proc/cpuinfo | awk '/^processor/{print $3}' | wc -l " ) do
    its('stdout.strip.to_i') { should be == 2 }
  end
end

# Day2 check for RAM

control 'TF UAT rhel RAM Day 2' do
  impact 1.0
  title 'Check total RAM Day 2'
  desc 'Checking the RAM on the server Day 2'
  describe command("(awk '{ print $2 }' /proc/meminfo |head -n1)| awk '{print $1/1048576}'|  awk '{print ($0-int($0)>0)?int($0)+1:int($0)}'" ) do 
    its('stdout.strip.to_i') { should be == 4 }
  end
end

# Day2 check for creation of new filesystems /app_1gb, /app_2gb, /app_3gb with 2NDUNIXID as owner, dce as group and specific sizing specified below

control 'TF UAT rhel /app_1gb check' do
  impact 1.0
  title '/app_1gb Configuration Check'  
  desc "Control to check TF provider mount /app_1gb"
    describe file('/app_1gb') do
      it { should exist }
      its('owner') { should eq '2NDUNIXID' }
      its('group') { should eq 'dce' }
    end

  if os.release.start_with?('6')
    describe command("lsblk | grep /app_1gb  | awk '{print $5'}") do
      its(:stdout) { should match '992M' }
    end

  elsif os.release.start_with?('7')
    describe command("lsblk | grep /app_1gb  | awk '{print $4'}") do
      its(:stdout) { should match '992M' }
    end
  end
end

  control 'TF UAT rhel /app_2gb check' do
    impact 1.0
    title '/app_2gb Configuration Check'  
    desc "Control to check TF provider mount /app_2gb"
      describe file('/app_2gb') do
        it { should exist }
        its('owner') { should eq '2NDUNIXID' }
        its('group') { should eq 'dce' }
      end
  
      if os.release.start_with?('6')
        describe command("lsblk | grep /app_2gb  | awk '{print $5'}") do
          its(:stdout) { should match '2G' }
        end
    
      elsif os.release.start_with?('7')
        describe command("lsblk | grep /app_2gb  | awk '{print $4'}") do
          its(:stdout) { should match '2G' }
        end
      end
    end

    control 'TF UAT rhel /app_3gb check' do
      impact 1.0
      title '/app_3gb Configuration Check'  
      desc "Control to check TF provider mount /app_3gb"
        describe file('/app_3gb') do
          it { should exist }
          its('owner') { should eq '2NDUNIXID' }
          its('group') { should eq 'dce' }
        end
    
        if os.release.start_with?('6')
          describe command("lsblk | grep /app_3gb  | awk '{print $5'}") do
            its(:stdout) { should match '3G' }
          end
      
        elsif os.release.start_with?('7')
          describe command("lsblk | grep /app_3gb  | awk '{print $4'}") do
            its(:stdout) { should match '3G' }
          end
        end
      end
