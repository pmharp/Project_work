# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Security::Mgmt::V2019_01_01
  module Models
    #
    # Factors that increase our confidence that the alert is a true positive
    #
    class AlertConfidenceReason

      include MsRestAzure

      # @return [String] Type of confidence factor
      attr_accessor :type

      # @return [String] description of the confidence reason
      attr_accessor :reason


      #
      # Mapper for AlertConfidenceReason class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'AlertConfidenceReason',
          type: {
            name: 'Composite',
            class_name: 'AlertConfidenceReason',
            model_properties: {
              type: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'type',
                type: {
                  name: 'String'
                }
              },
              reason: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'reason',
                type: {
                  name: 'String'
                }
              }
            }
          }
        }
      end
    end
  end
end
