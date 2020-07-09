#
# Copyright:: 2019, Chef Software Inc.
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
        # metadata.rb supports methods should contain valid platforms.
        #
        # @example
        #
        #   # bad
        #   supports 'darwin'
        #   supports 'mswin'
        #
        #   # good
        #   supports 'mac_os_x'
        #   supports 'windows'
        #
        class InvalidPlatformMetadata < Cop
          include ::RuboCop::Chef::PlatformHelpers

          MSG = 'metadata.rb "supports" platform is invalid'.freeze

          def_node_matcher :supports?, '(send nil? :supports $str ...)'

          def_node_matcher :supports_array?, <<-PATTERN
            (block
              (send
                $(array ...) :each)
              (args
                (arg _))
              (send nil? :supports (lvar _)))
          PATTERN

          def on_send(node)
            supports?(node) do |plat|
              if INVALID_PLATFORMS[plat.str_content]
                add_offense(plat, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def on_block(node)
            supports_array?(node) do |plats|
              plats.values.each do |plat|
                if INVALID_PLATFORMS[plat.str_content]
                  add_offense(plat, location: :expression, message: MSG, severity: :refactor)
                end
              end
            end
          end

          def autocorrect(node)
            correct_string = corrected_platform_source(node)
            if correct_string
              lambda do |corrector|
                corrector.replace(node.loc.expression, correct_string)
              end
            end
          end

          # private

          def corrected_platform_source(node)
            val = INVALID_PLATFORMS[node.str_content.delete(',').downcase]
            return false unless val

            # if the value was previously quoted make sure to quote it again
            node.source.match?(/^('|")/) ? "'" + val + "'" : val
          end
        end
      end
    end
  end
end
