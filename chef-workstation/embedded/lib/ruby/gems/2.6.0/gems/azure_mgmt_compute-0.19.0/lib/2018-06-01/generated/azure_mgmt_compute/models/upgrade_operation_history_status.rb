# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Compute::Mgmt::V2018_06_01
  module Models
    #
    # Information about the current running state of the overall upgrade.
    #
    class UpgradeOperationHistoryStatus

      include MsRestAzure

      # @return [UpgradeState] Code indicating the current status of the
      # upgrade. Possible values include: 'RollingForward', 'Cancelled',
      # 'Completed', 'Faulted'
      attr_accessor :code

      # @return [DateTime] Start time of the upgrade.
      attr_accessor :start_time

      # @return [DateTime] End time of the upgrade.
      attr_accessor :end_time


      #
      # Mapper for UpgradeOperationHistoryStatus class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'UpgradeOperationHistoryStatus',
          type: {
            name: 'Composite',
            class_name: 'UpgradeOperationHistoryStatus',
            model_properties: {
              code: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'code',
                type: {
                  name: 'Enum',
                  module: 'UpgradeState'
                }
              },
              start_time: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'startTime',
                type: {
                  name: 'DateTime'
                }
              },
              end_time: {
                client_side_validation: true,
                required: false,
                read_only: true,
                serialized_name: 'endTime',
                type: {
                  name: 'DateTime'
                }
              }
            }
          }
        }
      end
    end
  end
end
