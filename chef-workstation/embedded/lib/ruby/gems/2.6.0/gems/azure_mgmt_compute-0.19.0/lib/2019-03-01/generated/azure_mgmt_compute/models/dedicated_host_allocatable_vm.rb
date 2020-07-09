# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_03_01
  module Models
    #
    # Represents the dedicated host unutilized capacity in terms of a specific
    # VM size.
    #
    class DedicatedHostAllocatableVM

      include MsRestAzure

      # @return [String] VM size in terms of which the unutilized capacity is
      # represented.
      attr_accessor :vm_size

      # @return [Float] Maximum number of VMs of size vmSize that can fit in
      # the dedicated host's remaining capacity.
      attr_accessor :count


      #
      # Mapper for DedicatedHostAllocatableVM class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'DedicatedHostAllocatableVM',
          type: {
            name: 'Composite',
            class_name: 'DedicatedHostAllocatableVM',
            model_properties: {
              vm_size: {
                client_side_validation: true,
                required: false,
                serialized_name: 'vmSize',
                type: {
                  name: 'String'
                }
              },
              count: {
                client_side_validation: true,
                required: false,
                serialized_name: 'count',
                type: {
                  name: 'Double'
                }
              }
            }
          }
        }
      end
    end
  end
end
