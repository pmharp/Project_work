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
      module ChefRedundantCode
        # There is no need to pass `distribution node['lsb']['codename']` to an apt_repository resource as this is done automatically by the apt_repository resource.
        #
        #   # bad
        #   apt_repository 'my repo' do
        #     uri 'http://packages.example.com/debian'
        #     components %w(stable main)
        #     deb_src false
        #     distribution node['lsb']['codename']
        #   end
        #
        #   # good
        #   apt_repository 'my repo' do
        #     uri 'http://packages.example.com/debian'
        #     components %w(stable main)
        #     deb_src false
        #   end
        #
        class AptRepositoryDistributionDefault < Cop
          include RuboCop::Chef::CookbookHelpers
          include RangeHelp

          MSG = "There is no need to pass `distribution node['lsb']['codename']` to an apt_repository resource as this is done automatically by the apt_repository resource.".freeze

          def_node_matcher :default_dist?, <<-PATTERN
            (send nil? :distribution (send (send (send nil? :node) :[] ({sym str} {:lsb "lsb"})) :[] ({sym str} {:codename "codename"})))
          PATTERN

          def on_block(node)
            match_property_in_resource?(:apt_repository, 'distribution', node) do |dist|
              ## require 'pry'; binding.pry
              default_dist?(dist) do
                add_offense(dist, location: :expression, message: MSG, severity: :refactor)
              end
            end
          end

          def autocorrect(node)
            lambda do |corrector|
              corrector.remove(range_with_surrounding_space(range: node.loc.expression, side: :left))
            end
          end
        end
      end
    end
  end
end
