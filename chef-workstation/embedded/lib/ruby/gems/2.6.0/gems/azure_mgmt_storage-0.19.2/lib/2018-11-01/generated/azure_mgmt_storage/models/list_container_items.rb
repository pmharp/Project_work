# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Storage::Mgmt::V2018_11_01
  module Models
    #
    # The list of blob containers.
    #
    class ListContainerItems

      include MsRestAzure

      # @return [Array<ListContainerItem>] The list of blob containers.
      attr_accessor :value


      #
      # Mapper for ListContainerItems class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'ListContainerItems',
          type: {
            name: 'Composite',
            class_name: 'ListContainerItems',
            model_properties: {
              value: {
                client_side_validation: true,
                required: false,
                serialized_name: 'value',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'ListContainerItemElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'ListContainerItem'
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
