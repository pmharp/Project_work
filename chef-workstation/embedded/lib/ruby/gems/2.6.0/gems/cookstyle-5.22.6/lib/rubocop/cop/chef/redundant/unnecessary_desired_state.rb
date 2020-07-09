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
      module ChefRedundantCode
        # There is no need to set a property to desired_state: true as all properties have a desired_state of true by default.
        #
        # @example
        #
        #   # bad
        #   property :foo, String, desired_state: true
        #
        class UnnecessaryDesiredState < Cop
          include RangeHelp

          MSG = 'There is no need to set a property to desired_state: true as all properties have a desired_state of true by default.'.freeze

          def_node_matcher :property?, <<-PATTERN
            (send nil? {:property :attribute} (sym _) ... $(hash ...))
          PATTERN

          def on_send(node)
            property?(node) do |hash_vals|
              hash_vals.each_pair do |k, v|
                if k == s(:sym, :desired_state) && v == s(:true) # cookstyle: disable Lint/BooleanSymbol
                  add_offense(v.parent, location: :expression, message: MSG, severity: :refactor)
                end
              end
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              range = range_with_surrounding_comma(range_with_surrounding_space(range: node.loc.expression, side: :left), :left)
              corrector.remove(range)
            end
          end
        end
      end
    end
  end
end
