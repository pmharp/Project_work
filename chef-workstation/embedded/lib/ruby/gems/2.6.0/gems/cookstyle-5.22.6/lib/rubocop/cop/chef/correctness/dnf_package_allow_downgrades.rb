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
        # dnf_package does not support the allow_downgrades property
        #
        # @example
        #
        #   # bad
        #   dnf_package 'nginx' do
        #     version '1.2.3'
        #     allow_downgrades true
        #   end
        #
        #   # good
        #   dnf_package 'nginx' do
        #     version '1.2.3'
        #   end
        #
        class DnfPackageAllowDowngrades < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'dnf_package does not support the allow_downgrades property'.freeze

          def on_block(node)
            match_property_in_resource?(:dnf_package, :allow_downgrades, node) do |prop|
              add_offense(prop, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
