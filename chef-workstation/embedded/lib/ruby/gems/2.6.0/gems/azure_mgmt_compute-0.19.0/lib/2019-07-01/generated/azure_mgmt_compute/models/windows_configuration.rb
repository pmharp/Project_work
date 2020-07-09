# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_07_01
  module Models
    #
    # Specifies Windows operating system settings on the virtual machine.
    #
    class WindowsConfiguration

      include MsRestAzure

      # @return [Boolean] Indicates whether virtual machine agent should be
      # provisioned on the virtual machine. <br><br> When this property is not
      # specified in the request body, default behavior is to set it to true.
      # This will ensure that VM Agent is installed on the VM so that
      # extensions can be added to the VM later.
      attr_accessor :provision_vmagent

      # @return [Boolean] Indicates whether Automatic Updates is enabled for
      # the Windows virtual machine. Default value is true. <br><br> For
      # virtual machine scale sets, this property can be updated and updates
      # will take effect on OS reprovisioning.
      attr_accessor :enable_automatic_updates

      # @return [String] Specifies the time zone of the virtual machine. e.g.
      # "Pacific Standard Time"
      attr_accessor :time_zone

      # @return [Array<AdditionalUnattendContent>] Specifies additional base-64
      # encoded XML formatted information that can be included in the
      # Unattend.xml file, which is used by Windows Setup.
      attr_accessor :additional_unattend_content

      # @return [WinRMConfiguration] Specifies the Windows Remote Management
      # listeners. This enables remote Windows PowerShell.
      attr_accessor :win_rm


      #
      # Mapper for WindowsConfiguration class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'WindowsConfiguration',
          type: {
            name: 'Composite',
            class_name: 'WindowsConfiguration',
            model_properties: {
              provision_vmagent: {
                client_side_validation: true,
                required: false,
                serialized_name: 'provisionVMAgent',
                type: {
                  name: 'Boolean'
                }
              },
              enable_automatic_updates: {
                client_side_validation: true,
                required: false,
                serialized_name: 'enableAutomaticUpdates',
                type: {
                  name: 'Boolean'
                }
              },
              time_zone: {
                client_side_validation: true,
                required: false,
                serialized_name: 'timeZone',
                type: {
                  name: 'String'
                }
              },
              additional_unattend_content: {
                client_side_validation: true,
                required: false,
                serialized_name: 'additionalUnattendContent',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'AdditionalUnattendContentElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'AdditionalUnattendContent'
                      }
                  }
                }
              },
              win_rm: {
                client_side_validation: true,
                required: false,
                serialized_name: 'winRM',
                type: {
                  name: 'Composite',
                  class_name: 'WinRMConfiguration'
                }
              }
            }
          }
        }
      end
    end
  end
end
