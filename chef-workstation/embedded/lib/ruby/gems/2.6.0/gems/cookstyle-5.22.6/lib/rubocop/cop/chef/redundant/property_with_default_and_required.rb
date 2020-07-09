#
# Copyright:: Copyright 2019-2020, Chef Software Inc.
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
      module ChefRedundantCode
        # When using properties in a custom resource you shouldn't set a property to
        # required and then provide a default value. If a property is required the
        # user will always pass in a value and the default will never be used. In Chef
        # Infra Client 13+ this became an error.
        #
        # @example
        #
        #   # bad
        #   property :bob, String, required: true, default: 'foo'
        #
        #   # good
        #   property :bob, String, required: true
        #
        class PropertyWithRequiredAndDefault < Cop
          include RangeHelp

          MSG = 'Resource properties should not be both required and have a default value. This will fail on Chef Infra Client 13+'.freeze

          # match on a property or attribute that has any name and any type and a hash that
          # contains default: true and required: true. These are wrapped in <> which means
          # the order doesn't matter in the hash.
          def_node_matcher :required_and_default?, <<-PATTERN
            (send nil? {:property :attribute} (sym _) ... (hash <$(pair (sym :default) ...) (pair (sym :required) true) ...>))
          PATTERN

          def on_send(node)
            required_and_default?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              required_and_default?(node) do |default|
                range = range_with_surrounding_comma(range_with_surrounding_space(range: default.loc.expression, side: :left), :left)
                corrector.remove(range)
              end
            end
          end
        end
      end
    end
  end
end
