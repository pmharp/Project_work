# encoding: utf-8
# copyright: 2018, The Authors

title 'Unknown server type'

# load data from Terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)
servername = params['TF_OUTPUT_RESOURCE_NAME-servername']['value']

# need servername test
only_if { sys_info.hostname.downcase == servername }

# Day1 check for Apache
control 'TF_OUTPUT_RESOURCE_NAME-Unknown Server Type' do
  impact 1.0
  title 'This is an unknown server type, please check server name'
  desc 'This is an unknown server type, please check server name'
  describe sys_info do
    its('hostname') { should eq 'Unknown_Server_Type' }
  end
end