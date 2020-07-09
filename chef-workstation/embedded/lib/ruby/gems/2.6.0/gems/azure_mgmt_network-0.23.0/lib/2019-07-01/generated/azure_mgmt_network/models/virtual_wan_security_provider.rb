# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2019_07_01
  module Models
    #
    # Collection of SecurityProviders.
    #
    class VirtualWanSecurityProvider

      include MsRestAzure

      # @return [String] Name of the security provider.
      attr_accessor :name

      # @return [String] Url of the security provider.
      attr_accessor :url

      # @return [VirtualWanSecurityProviderType] Name of the security provider.
      # Possible values include: 'External', 'Native'
      attr_accessor :type


      #
      # Mapper for VirtualWanSecurityProvider class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'VirtualWanSecurityProvider',
          type: {
            name: 'Composite',
            class_name: 'VirtualWanSecurityProvider',
            model_properties: {
              name: {
                client_side_validation: true,
                required: false,
                serialized_name: 'name',
                type: {
                  name: 'String'
                }
              },
              url: {
                client_side_validation: true,
                required: false,
                serialized_name: 'url',
                type: {
                  name: 'String'
                }
              },
              type: {
                client_side_validation: true,
                required: false,
                serialized_name: 'type',
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
