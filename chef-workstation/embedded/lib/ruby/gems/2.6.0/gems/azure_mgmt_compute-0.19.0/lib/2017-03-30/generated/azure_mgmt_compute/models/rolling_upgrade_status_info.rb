# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2017_03_30
  module Models
    #
    # The status of the latest virtual machine scale set rolling upgrade.
    #
    class RollingUpgradeStatusInfo < Resource

      include MsRestAzure

      # @return [RollingUpgradePolicy] The rolling upgrade policies applied for
      # this upgrade.
      attr_accessor :policy

      # @return [RollingUpgradeRunningStatus] Information about the current
      # running state of the overall upgrade.
      attr_accessor :running_status

      # @return [RollingUpgradeProgressInfo] Information about the number of
      # virtual machine instances in each upgrade state.
      attr_accessor :progress

      # @return [ApiError] Error details for this upgrade, if there are any.
      attr_accessor :error


      #
      # Mapper for RollingUpgradeStatusInfo class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'RollingUpgradeStatusInfo',
          type: {
            name: 'Composite',
            class_name: 'RollingUpgradeStatusInfo',
            model_properties: {
              id: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'id',
                type: {
                  name: 'String'
                }
              },
              name: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'name',
                type: {
                  name: 'String'
                }
              },
              type: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'type',
                type: {
                  name: 'String'
                }
              },
              location: {
                client_side_validation: true,
                required: true,
                serialized_name: 'location',
                type: {
                  name: 'String'
                }
              },
              tags: {
                client_side_validation: true,
                required: false,
                serialized_name: 'tags',
                type: {
                  name: 'Dictionary',
                  value: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'StringElementType',
                      type: {
                        name: 'String'
                      }
                  }
                }
              },
              policy: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.policy',
                type: {
                  name: 'Composite',
                  class_name: 'RollingUpgradePolicy'
                }
              },
              running_status: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.runningStatus',
                type: {
                  name: 'Composite',
                  class_name: 'RollingUpgradeRunningStatus'
                }
              },
              progress: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.progress',
                type: {
                  name: 'Composite',
                  class_name: 'RollingUpgradeProgressInfo'
                }
              },
              error: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'properties.error',
                type: {
                  name: 'Composite',
                  class_name: 'ApiError'
                }
              }
            }
          }
        }
      end
    end
  end
end
