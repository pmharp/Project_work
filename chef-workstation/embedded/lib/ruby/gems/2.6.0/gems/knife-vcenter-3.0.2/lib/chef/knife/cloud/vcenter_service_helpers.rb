# frozen_string_literal: true
#
# Author:: Chef Partner Engineering (<partnereng@chef.io>)
# Copyright:: Copyright (c) 2017-2018 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "chef/knife/cloud/helpers"

class Chef
  # The main knife class
  class Knife
    # The main cloud class from knife-cloud
    class Cloud
      # Module that creates the helpers for this gem
      module VcenterServiceHelpers
        include Chef::Knife::Cloud::Helpers

        # Creates the object for vCenterService
        #
        def create_service_instance
          Chef::Knife::Cloud::VcenterService.new(username: locate_config_value(:vcenter_username),
                                                 password: locate_config_value(:vcenter_password),
                                                 host: locate_config_value(:vcenter_host),
                                                 verify_ssl: verify_ssl?)
        end

        # Do we have valid SSL?
        #
        def verify_ssl?
          !locate_config_value(:vcenter_disable_ssl_verify)
        end

        # Validate the options and fail out if something isn't there
        #
        def validate!
          check_for_missing_config_values!(:vcenter_username, :vcenter_password, :vcenter_host)
        end

        # rubocop:disable Style/GuardClause
        # Checks for any missing values
        #
        # @param [Object] keys makes sure that the values are all not nil
        def check_for_missing_config_values!(*keys)
          missing = keys.select { |x| locate_config_value(x).nil? }

          unless missing.empty?
            ui.error(format("The following required parameters are missing: %s", missing.join(", ")))
            exit(1)
          end
        end
      end
    end
  end
end
