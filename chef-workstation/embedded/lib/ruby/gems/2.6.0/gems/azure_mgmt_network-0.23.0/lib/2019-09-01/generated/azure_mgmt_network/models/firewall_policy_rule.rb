# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2019_09_01
  module Models
    #
    # Properties of the rule.
    #
    class FirewallPolicyRule

      include MsRestAzure

      @@discriminatorMap = Hash.new
      @@discriminatorMap["FirewallPolicyNatRule"] = "FirewallPolicyNatRule"
      @@discriminatorMap["FirewallPolicyFilterRule"] = "FirewallPolicyFilterRule"

      def initialize
        @ruleType = "FirewallPolicyRule"
      end

      attr_accessor :ruleType

      # @return [String] The name of the rule.
      attr_accessor :name

      # @return [Integer] Priority of the Firewall Policy Rule resource.
      attr_accessor :priority


      #
      # Mapper for FirewallPolicyRule class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'FirewallPolicyRule',
          type: {
            name: 'Composite',
            polymorphic_discriminator: 'ruleType',
            uber_parent: 'FirewallPolicyRule',
            class_name: 'FirewallPolicyRule',
            model_properties: {
              name: {
                client_side_validation: true,
                required: false,
                serialized_name: 'name',
                type: {
                  name: 'String'
                }
              },
              priority: {
                client_side_validation: true,
                required: false,
                serialized_name: 'priority',
                constraints: {
                  InclusiveMaximum: 65000,
                  InclusiveMinimum: 100
                },
                type: {
                  name: 'Number'
                }
              }
            }
          }
        }
      end
    end
  end
end
