# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_07_01
  module Models
    #
    # Enables or disables a capability on the virtual machine or virtual
    # machine scale set.
    #
    class AdditionalCapabilities

      include MsRestAzure

      # @return [Boolean] The flag that enables or disables a capability to
      # have one or more managed data disks with UltraSSD_LRS storage account
      # type on the VM or VMSS. Managed disks with storage account type
      # UltraSSD_LRS can be added to a virtual machine or virtual machine scale
      # set only if this property is enabled.
      attr_accessor :ultra_ssdenabled


      #
      # Mapper for AdditionalCapabilities class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'AdditionalCapabilities',
          type: {
            name: 'Composite',
            class_name: 'AdditionalCapabilities',
            model_properties: {
              ultra_ssdenabled: {
                client_side_validation: true,
                required: false,
                serialized_name: 'ultraSSDEnabled',
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
