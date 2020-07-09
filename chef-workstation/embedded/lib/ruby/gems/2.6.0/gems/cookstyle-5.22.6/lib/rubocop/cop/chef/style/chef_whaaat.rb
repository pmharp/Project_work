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
        # Checks for comments that mention "Chef" without context. Do you mean Chef Infra or Chef Software?
        #
        # @example
        #
        #   # bad
        #   Chef makes software
        #   Chef configures your systems
        #
        #   # good
        #   Chef Software makes software
        #   Chef Infra configures your systems
        #
        class ChefWhaaat < Cop
          MSG = 'Do you mean Chef (the company) or a Chef product (e.g. Chef Infra, Chef InSpec, etc)?'.freeze

          def investigate(processed_source)
            return unless processed_source.ast

            processed_source.comments.each do |comment|
              if comment.text.match?(/Chef [a-z]/) # https://rubular.com/r/0YzfDAbwJrDHix
                add_offense(comment, location: comment.loc.expression, message: MSG, severity: :refactor)
              end
            end
          end
        end
      end
    end
  end
end
