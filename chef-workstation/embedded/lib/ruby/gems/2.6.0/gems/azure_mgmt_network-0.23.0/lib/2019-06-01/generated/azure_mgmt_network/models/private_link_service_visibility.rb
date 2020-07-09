# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2019_06_01
  module Models
    #
    # Response for the CheckPrivateLinkServiceVisibility API service call.
    #
    class PrivateLinkServiceVisibility

      include MsRestAzure

      # @return [Boolean] Private Link Service Visibility (True/False).
      attr_accessor :visible


      #
      # Mapper for PrivateLinkServiceVisibility class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'PrivateLinkServiceVisibility',
          type: {
            name: 'Composite',
            class_name: 'PrivateLinkServiceVisibility',
            model_properties: {
              visible: {
                client_side_validation: true,
                required: false,
                serialized_name: 'visible',
                type: {
                  name: 'Boolean'
                }
              }
            }
          }
        }
      end
    end
  end
end
