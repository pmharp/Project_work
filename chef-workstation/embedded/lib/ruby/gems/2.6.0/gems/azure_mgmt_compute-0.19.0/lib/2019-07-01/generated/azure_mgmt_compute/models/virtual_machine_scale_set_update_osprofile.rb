# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_07_01
  module Models
    #
    # Describes a virtual machine scale set OS profile.
    #
    class VirtualMachineScaleSetUpdateOSProfile

      include MsRestAzure

      # @return [String] A base-64 encoded string of custom data.
      attr_accessor :custom_data

      # @return [WindowsConfiguration] The Windows Configuration of the OS
      # profile.
      attr_accessor :windows_configuration

      # @return [LinuxConfiguration] The Linux Configuration of the OS profile.
      attr_accessor :linux_configuration

      # @return [Array<VaultSecretGroup>] The List of certificates for addition
      # to the VM.
      attr_accessor :secrets


      #
      # Mapper for VirtualMachineScaleSetUpdateOSProfile class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'VirtualMachineScaleSetUpdateOSProfile',
          type: {
            name: 'Composite',
            class_name: 'VirtualMachineScaleSetUpdateOSProfile',
            model_properties: {
              custom_data: {
                client_side_validation: true,
                required: false,
                serialized_name: 'customData',
                type: {
                  name: 'String'
                }
              },
              windows_configuration: {
                client_side_validation: true,
                required: false,
                serialized_name: 'windowsConfiguration',
                type: {
                  name: 'Composite',
                  class_name: 'WindowsConfiguration'
                }
              },
              linux_configuration: {
                client_side_validation: true,
                required: false,
                serialized_name: 'linuxConfiguration',
                type: {
                  name: 'Composite',
                  class_name: 'LinuxConfiguration'
                }
              },
              secrets: {
                client_side_validation: true,
                required: false,
                serialized_name: 'secrets',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'VaultSecretGroupElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'VaultSecretGroup'
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
