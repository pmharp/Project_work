#
# Cookbook:: test
# Recipe:: resize_thin_pool_meta_data
#
# Copyright:: 2016-2017, Ontario Systems, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distribued on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Resize a thin volume
# Volume was created in create_thin recipe
#
lvm_thin_pool_meta_data 'lv-thin_tmeta_data_resize' do
  action [:resize]
  name 'lv-thin_tmeta'
  group 'vg-test'
  pool 'lv-thin'
  size '128M'
  filesystem 'ext3'
  mount_point '/mnt/thin1'
end
