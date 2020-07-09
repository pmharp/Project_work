#
# Copyright:: Copyright 2019, Chef Software Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module RuboCop
  module Cop
    module Chef
      module ChefCorrectness
        # Pass valid platforms to the value_for_platform helper.
        #
        # @example
        #
        #   # bad
        #   value_for_platform(
        #     %w(rhel mac_os_x_server) => { 'default' => 'foo' },
        #     %w(sles) => { 'default' => 'bar' }
        #   )
        #   # good
        #   value_for_platform(
        #     %w(redhat mac_os_x) => { 'default' => 'foo' },
        #     %w(opensuseleap) => { 'default' => 'bar' }
        #   )
        #
        class InvalidPlatformValueForPlatformHelper < Cop
          include ::RuboCop::Chef::PlatformHelpers

          MSG = 'Pass valid platforms to the value_for_platform helper.'.freeze

          def_node_matcher :value_for_platform?, <<-PATTERN
          (send nil? :value_for_platform
            (hash
              $...
            )
          )
          PATTERN

          def on_send(node)
            value_for_platform?(node) do |plats|
              plats.each do |p_hash|
                if p_hash.key.array_type?
                  p_hash.key.values.each do |plat|
                    add_offense(plat, location: :expression, message: MSG, severity: :refactor) if INVALID_PLATFORMS.key?(plat.value)
                  end
                elsif INVALID_PLATFORMS.key?(p_hash.key.value)
                  add_offense(p_hash.key, location: :expression, message: MSG, severity: :refactor)
                end
              end
            end
          end
        end
      end
    end
  end
end
