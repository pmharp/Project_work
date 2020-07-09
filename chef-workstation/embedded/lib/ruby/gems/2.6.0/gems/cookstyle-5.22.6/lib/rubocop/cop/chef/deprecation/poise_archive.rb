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
      module ChefDeprecations
        # The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+.
        #
        # @example
        #
        #   # bad
        #   poise_archive 'https://example.com/myapp.tgz' do
        #     destination '/opt/myapp'
        #   end
        #
        #   # good
        #   archive_file 'https://example.com/myapp.tgz' do
        #     destination '/opt/myapp'
        #   end
        #
        class PoiseArchiveUsage < Cop
          include RuboCop::Chef::CookbookHelpers

          MSG = 'The poise_archive resource in the deprecated poise-archive should be replaced with the archive_file resource found in Chef Infra Client 15+'.freeze

          def_node_matcher :depends_poise_archive?, <<-PATTERN
            (send nil? :depends (str "poise-archive"))
          PATTERN

          def on_send(node)
            depends_poise_archive?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end

          def on_block(node)
            match_resource_type?(:poise_archive, node) do
              add_offense(node, location: :expression, message: MSG, severity: :refactor)
            end
          end
        end
      end
    end
  end
end
