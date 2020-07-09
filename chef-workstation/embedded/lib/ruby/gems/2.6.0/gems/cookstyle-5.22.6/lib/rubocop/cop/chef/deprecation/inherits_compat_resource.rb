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
      module ChefDeprecations
        # Resources written in the class based HWRP style should inherit from the 'Chef::Resource' class and not the 'ChefCompat::Resource' class from the deprecated compat_resource cookbook.
        #
        # @example
        #
        #  # bad
        #  class AptUpdate < ChefCompat::Resource
        #    # some resource code
        #  end
        #
        #  # good
        #  class AptUpdate < Chef::Resource
        #    # some resource code
        #  end
        #
        #  # better
        #  Write a custom resource using the custom resource DSL and avoid class based HWRPs entirely
        #
        class ResourceInheritsFromCompatResource < Cop
          MSG = "HWRP style resource should inherit from the 'Chef::Resource' class and not the 'ChefCompat::Resource' class from the deprecated compat_resource cookbook.".freeze

          def_node_matcher :inherits_from_compat_resource?, <<-PATTERN
          (class (const nil? _ ) (const (const nil? :ChefCompat) :Resource) ... )
          PATTERN

          def on_class(node)
            inherits_from_compat_resource?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.replace(node.loc.expression, node.loc.expression.source.gsub('ChefCompat', 'Chef'))
            end
          end
        end
      end
    end
  end
end
