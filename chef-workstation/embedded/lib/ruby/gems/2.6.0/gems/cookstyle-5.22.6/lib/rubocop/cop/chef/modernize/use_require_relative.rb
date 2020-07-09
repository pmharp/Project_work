#
# Copyright:: 2020, Chef Software Inc.
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
      module ChefModernize
        # Instead of using require with a File.expand_path and __FILE__ use the simpler require_relative method.
        #
        # @example
        #
        #   # bad
        #   require File.expand_path('../../libraries/helpers', __FILE__)
        #
        #   # good
        #   require_relative '../libraries/helpers'
        #
        class UseRequireRelative < Cop
          MSG = 'Instead of using require with a File.expand_path and __FILE__ use the simpler require_relative method.'.freeze

          def_node_matcher :require_with_expand_path?, <<-PATTERN
            (send nil? :require
              (send
                (const nil? :File) :expand_path
                $( str ... )
                $( str ... )))
          PATTERN

          def on_send(node)
            require_with_expand_path?(node) do |_file, path|
              add_offense(node, location: :expression, message: MSG, severity: :refactor) if path.source == '__FILE__'
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              require_with_expand_path?(node) do |file, _path|
                corrected_value = file.value
                corrected_value.slice!(%r{^../}) # take the first ../ off the path
                corrector.replace(node.loc.expression, "require_relative '#{corrected_value}'")
              end
            end
          end
        end
      end
    end
  end
end
