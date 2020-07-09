# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2019_03_01
  module Models
    #
    # Describes a scale-in policy for a virtual machine scale set.
    #
    class ScaleInPolicy

      include MsRestAzure

      # @return [Array<VirtualMachineScaleSetScaleInRules>] The rules to be
      # followed when scaling-in a virtual machine scale set. <br><br> Possible
      # values are: <br><br> **Default** When a virtual machine scale set is
      # scaled in, the scale set will first be balanced across zones if it is a
      # zonal scale set. Then, it will be balanced across Fault Domains as far
      # as possible. Within each Fault Domain, the virtual machines chosen for
      # removal will be the newest ones that are not protected from scale-in.
      # <br><br> **OldestVM** When a virtual machine scale set is being
      # scaled-in, the oldest virtual machines that are not protected from
      # scale-in will be chosen for removal. For zonal virtual machine scale
      # sets, the scale set will first be balanced across zones. Within each
      # zone, the oldest virtual machines that are not protected will be chosen
      # for removal. <br><br> **NewestVM** When a virtual machine scale set is
      # being scaled-in, the newest virtual machines that are not protected
      # from scale-in will be chosen for removal. For zonal virtual machine
      # scale sets, the scale set will first be balanced across zones. Within
      # each zone, the newest virtual machines that are not protected will be
      # chosen for removal. <br><br>
      attr_accessor :rules


      #
      # Mapper for ScaleInPolicy class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'ScaleInPolicy',
          type: {
            name: 'Composite',
            class_name: 'ScaleInPolicy',
            model_properties: {
              rules: {
                client_side_validation: true,
                required: false,
                serialized_name: 'rules',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'VirtualMachineScaleSetScaleInRulesElementType',
                      type: {
                        name: 'String'
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
