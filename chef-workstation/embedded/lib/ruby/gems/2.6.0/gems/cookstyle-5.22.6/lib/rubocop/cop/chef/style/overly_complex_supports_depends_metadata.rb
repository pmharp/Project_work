#
# Copyright:: 2020, Chef Software, Inc.
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
      module ChefStyle
        # Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set.  Setting multiple `supports` or `depends` values is simpler and easier to understand for new users.
        #
        # @example
        #
        #   # bad
        #
        #   %w( debian ubuntu ).each do |os|
        #     supports os
        #   end
        #
        #   %w( apt yum ).each do |cb|
        #     depends cb
        #   end
        #
        #   # good
        #
        #   supports 'debian'
        #   supports 'ubuntu'
        #
        #   depends 'apt'
        #   depends 'yum'
        #
        class OverlyComplexSupportsDependsMetadata < Cop
          MSG = "Don't loop over an array to set cookbook dependencies or supported platforms if you have fewer than three values to set.".freeze

          def_node_matcher :supports_depends_array?, <<-PATTERN
            (block
              (send
                $(array ...) :each)
              (args
                (arg _))
              (send nil? ${:supports :depends} (lvar _)))
          PATTERN

          def on_block(node)
            supports_depends_array?(node) do |array, _type|
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if array.values.count < 3
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              supports_depends_array?(node) do |array, type|
                corrected_value = array.values.map { |x| "#{type} '#{x.source}'" }
                corrector.replace(node.loc.expression, corrected_value.join("\n"))
              end
            end
          end
        end
      end
    end
  end
end
