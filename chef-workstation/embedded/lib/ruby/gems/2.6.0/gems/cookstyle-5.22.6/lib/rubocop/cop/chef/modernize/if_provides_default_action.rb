#
# Copyright:: 2019, Chef Software, Inc.
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
        # if defined?(default_action) is no longer necessary in Chef Resources as default_action shipped in Chef 10.8.
        #
        # @example
        #
        #   # bad
        #   default_action :foo if defined?(default_action)
        #
        #   # good
        #   default_action :foo
        #
        class IfProvidesDefaultAction < Cop
          MSG = 'if defined?(default_action) is no longer necessary in Chef Resources as default_action shipped in Chef 10.8.'.freeze

          def on_defined?(node)
            return unless node.arguments.first == s(:send, nil, :default_action)
            node = node.parent if node.parent.respond_to?(:if?) && node.parent.if? # we want the whole if statement
            add_offense(node, location: :expression, message: MSG, severity: :refactor)
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.children[1].source)
            end
          end
        end
      end
    end
  end
end
