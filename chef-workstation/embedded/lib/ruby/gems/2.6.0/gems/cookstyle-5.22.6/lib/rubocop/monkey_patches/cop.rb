module RuboCop
  module Cop
    class Cop
      # This is a copy of the #target_rails_version method from rubocop-rails
      def target_chef_version
        @config.target_chef_version
      end
    end
  end
end
