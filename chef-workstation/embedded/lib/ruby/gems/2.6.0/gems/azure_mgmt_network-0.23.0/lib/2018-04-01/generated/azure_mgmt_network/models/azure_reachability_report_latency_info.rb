# encoding: utf-8
# Code generated by Microsoft (R) AutoRest Code Generator.
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module Azure::Network::Mgmt::V2018_04_01
  module Models
    #
    # Details on latency for a time series.
    #
    class AzureReachabilityReportLatencyInfo

      include MsRestAzure

      # @return [DateTime] The time stamp.
      attr_accessor :time_stamp

      # @return [Integer] The relative latency score between 1 and 100, higher
      # values indicating a faster connection.
      attr_accessor :score


      #
      # Mapper for AzureReachabilityReportLatencyInfo class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'AzureReachabilityReportLatencyInfo',
          type: {
            name: 'Composite',
            class_name: 'AzureReachabilityReportLatencyInfo',
            model_properties: {
              time_stamp: {
                client_side_validation: true,
                required: false,
                serialized_name: 'timeStamp',
                type: {
                  name: 'DateTime'
                }
              },
              score: {
                client_side_validation: true,
                required: false,
                serialized_name: 'score',
                constraints: {
                  InclusiveMaximum: 100,
                  InclusiveMinimum: 1
                },
                type: {
                  name: 'Number'
                }
              }
            }
          }
        }
      end
    end
  end
end
