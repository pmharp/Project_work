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
        # Every Chef Infra resources already include a sensitive property with a default value of false.
        #
        # # bad
        # property :sensitive, [true, false], default: false
        #
        class SensitivePropertyInResource < Cop
          MSG = 'Every Chef Infra resources already include a sensitive property with a default value of false.'.freeze

          def_node_matcher :sensitive_property?, <<-PATTERN
            (send nil? {:property :attribute} (sym :sensitive) ... (hash (pair (sym :default) (false))))
          PATTERN

          def on_send(node)
            if sensitive_property?(node)
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(node.source_range)
            end
          end
        end
      end
    end
  end
end
