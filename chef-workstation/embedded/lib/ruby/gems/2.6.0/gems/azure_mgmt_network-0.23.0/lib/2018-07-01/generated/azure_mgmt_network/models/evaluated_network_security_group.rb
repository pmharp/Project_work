# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2018_07_01
  module Models
    #
    # Results of network security group evaluation.
    #
    class EvaluatedNetworkSecurityGroup

      include MsRestAzure

      # @return [String] Network security group ID.
      attr_accessor :network_security_group_id

      # @return [MatchedRule]
      attr_accessor :matched_rule

      # @return [Array<NetworkSecurityRulesEvaluationResult>] List of network
      # security rules evaluation results.
      attr_accessor :rules_evaluation_result


      #
      # Mapper for EvaluatedNetworkSecurityGroup class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'EvaluatedNetworkSecurityGroup',
          type: {
            name: 'Composite',
            class_name: 'EvaluatedNetworkSecurityGroup',
            model_properties: {
              network_security_group_id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'networkSecurityGroupId',
                type: {
                  name: 'String'
                }
              },
              matched_rule: {
                client_side_validation: true,
                required: false,
                serialized_name: 'matchedRule',
                type: {
                  name: 'Composite',
                  class_name: 'MatchedRule'
                }
              },
              rules_evaluation_result: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'rulesEvaluationResult',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'NetworkSecurityRulesEvaluationResultElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'NetworkSecurityRulesEvaluationResult'
                      }
                  }
                }
              }
            }
          }
        }
      end
    end
  end
end
